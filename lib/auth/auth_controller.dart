import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController{
  final isLoading = false.obs;
  final _isLoggedIn = false.obs;
  final obscurePassword = true.obs;
  final String baseUrl = 'http://192.168.125.65:5000';  // Local server address

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    print('AuthController initialized');
    print('Using baseUrl: $baseUrl');
    checkLoginStatus();
    testBackendConnection();
  }

  @override
  void onClose() {
    print('AuthController disposed');
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> checkLoginStatus() async {
    try {
      print('Checking login status...');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      _isLoggedIn.value = token != null;
      print('Login status: ${_isLoggedIn.value}');
    } catch (e) {
      print('Error checking login status: $e');
      _isLoggedIn.value = false;
    }
  }

  Future<void> testBackendConnection() async {
    try {
      print('Testing backend connection to: $baseUrl');
      final testUrl = '$baseUrl/api/auth';
      print('Testing endpoint: $testUrl');
      
      final response = await http.get(
        Uri.parse(testUrl),
        headers: {
          'Accept': 'application/json',
        },
      );
      print('Backend connection test response: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        print('Server is running and accessible');
        Get.snackbar(
          'Server Connected',
          'Successfully connected to the server',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF00C6AD),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        print('Server responded with status: ${response.statusCode}');
        Get.snackbar(
          'Server Response',
          'Server responded with status: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('Backend connection test failed: $e');
      Get.snackbar(
        'Connection Error',
        'Cannot connect to the server at $baseUrl. Please check if the server is running on port 5000.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login(String email, String password) async {
    print('Attempting login with email: $email');
    print('Using baseUrl: $baseUrl');
    isLoading.value = true;
    try {
      final url = '$baseUrl/api/auth';  // Corrected endpoint
      print('Sending login request to: $url');
      
      final requestBody = {
        'email': email,
        'password': password,
        'role': 'patient',
      };
      print('Request body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response headers: ${response.headers}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('Decoded response data: $responseData');

        if (responseData['status'] == 'success' || responseData['token'] != null) {
          final token = responseData['token'];
          print('Login successful. Token received: $token');
          
          // Save token and login status
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setBool('isLoggedIn', true);
          
          _isLoggedIn.value = true;
          Get.offAllNamed('/dashboard');
          
          Get.snackbar(
            'Success',
            'Welcome back!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF00C6AD),
            colorText: Colors.white,
          );
        } else {
          print('Login failed: ${responseData['message']}');
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Login failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        print('Login failed with status: ${response.statusCode}');
        print('Error response body: ${response.body}');
        Get.snackbar(
          'Error',
          'Login failed with status: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Login error: $e');
      Get.snackbar(
        'Connection Error',
        'Cannot connect to the server. Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup() async {
    // if (!_validateSignupForm()) return;

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call

      // Store user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', emailController.text);
      await prefs.setString('userName', nameController.text);
      await prefs.setString('userPhone', phoneController.text);

      _isLoggedIn.value = true;
      Get.offAllNamed('/dashboard'); // Navigate to home page

      _clearForm();

      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF00C6AD),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Signup failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    print('Attempting logout...');
    isLoading.value = true;
    try {
      // Clear stored data
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      _isLoggedIn.value = false;
      Get.offAllNamed('/login');

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF00C6AD),
        colorText: Colors.white,
      );
      print('Logout successful');
    } catch (e) {
      print('Logout error: $e');
      Get.snackbar(
        'Error',
        'Logout failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateLoginForm() {
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  bool _validateSignupForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (phoneController.text.isEmpty || !GetUtils.isPhoneNumber(phoneController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    phoneController.clear();
  }
}