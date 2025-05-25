import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/auth/auth_controller.dart';


class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //////////////////// Don't remove ////////////////////////
                const SizedBox(height: 40),
                // Image.asset(
                //   AppAssets.logo,
                //   height: 120,
                // ),
                // const SizedBox(height: 40),

                Text(
                  'Welcome Back!',
                  style: Get.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to continue using the app',
                  style: Get.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildLoginButton(),
                const SizedBox(height: 24),
                _buildDivider(),
                // const SizedBox(height: 24),
                // _buildSocialLoginButtons(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Get.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextField(
      controller: controller.passwordController,
      obscureText: controller.obscurePassword.value,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscurePassword.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ));
  }

  Widget _buildLoginButton() {
    return Obx(() => ElevatedButton(
      onPressed: controller.isLoading.value ? null : controller.login,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: controller.isLoading.value
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[400])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[400])),
      ],
    );
  }

  // Widget _buildSocialLoginButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       _buildSocialButton(
  //         icon: Icons.g_mobiledata,
  //         label: 'Google',
  //         onPressed: () {
  //           // TODO: Implement Google login
  //         },
  //       ),
  //       _buildSocialButton(
  //         icon: Icons.facebook,
  //         label: 'Facebook',
  //         onPressed: () {
  //           // TODO: Implement Facebook login
  //         },
  //       ),
  //       _buildSocialButton(
  //         icon: Icons.apple,
  //         label: 'Apple',
  //         onPressed: () {
  //           // TODO: Implement Apple login
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSocialButton({
  //   required IconData icon,
  //   required String label,
  //   required VoidCallback onPressed,
  // }) {
  //   return InkWell(
  //     onTap: onPressed,
  //     borderRadius: BorderRadius.circular(12),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: 24,
  //         vertical: 12,
  //       ),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey[300]!),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Column(
  //         children: [
  //           Icon(icon, size: 24),
  //           const SizedBox(height: 4),
  //           Text(
  //             label,
  //             style: const TextStyle(fontSize: 12),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}