import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final RxList<Map<String, dynamic>> availableDoctors = <Map<String, dynamic>>[].obs;
  final RxList<String> specialties = <String>[].obs;
  final RxString selectedSpecialty = ''.obs;
  final RxString selectedDate = ''.obs;
  final RxString selectedTime = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSpecialties();
    loadDoctors();
  }

  void loadSpecialties() {
    specialties.value = [
      'Cardiology',
      'Pediatrics',
      'Orthopedics',
      'Dermatology',
      'Neurology',
      'General Medicine',
      'Dentistry',
      'Ophthalmology'
    ];
  }

  void loadDoctors() {
    // Simulated data - In a real app, this would come from an API
    availableDoctors.value = [
      {
        'name': 'Dr. John Smith',
        'specialty': 'Cardiology',
        'experience': '15 years',
        'rating': 4.8,
        'image': 'assets/images/doctor1.jpg',
        'available_slots': ['09:00 AM', '10:00 AM', '11:00 AM', '02:00 PM'],
        'fee': '\$100'
      },
      {
        'name': 'Dr. Sarah Johnson',
        'specialty': 'Pediatrics',
        'experience': '10 years',
        'rating': 4.6,
        'image': 'assets/images/doctor2.jpg',
        'available_slots': ['09:30 AM', '10:30 AM', '11:30 AM', '03:00 PM'],
        'fee': '\$80'
      },
      {
        'name': 'Dr. Michael Chen',
        'specialty': 'Orthopedics',
        'experience': '12 years',
        'rating': 4.7,
        'image': 'assets/images/doctor1.jpg',
        'available_slots': ['08:00 AM', '10:00 AM', '02:00 PM', '04:00 PM'],
        'fee': '\$120'
      }
    ];
  }

  void setSelectedSpecialty(String specialty) {
    selectedSpecialty.value = specialty;
  }

  void setSelectedDate(String date) {
    selectedDate.value = date;
  }

  void setSelectedTime(String time) {
    selectedTime.value = time;
  }

  Future<void> bookAppointment(Map<String, dynamic> doctor) async {
    isLoading.value = true;
    try {
      // Simulated API call
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Appointment booked successfully with ${doctor['name']}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF00C6AD),
        colorText: Colors.white,
      );
      // In a real app, you would send notification via WhatsApp/Email here
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to book appointment. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, dynamic>> getFilteredDoctors() {
    if (selectedSpecialty.isEmpty) return availableDoctors;
    return availableDoctors.where((doctor) =>
    doctor['specialty'] == selectedSpecialty.value).toList();
  }
}