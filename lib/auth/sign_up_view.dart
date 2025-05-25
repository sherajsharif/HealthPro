import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/auth/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image.asset(
                //   AppAssets.logo,
                //   height: 100,
                // ),
                // const SizedBox(height: 32),
                Text(
                  'Create your Account',
                  style: Get.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Join RI Medicare to access healthcare services',
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildNameField(),
                const SizedBox(height: 16),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPhoneField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 24),
                _buildSignupButton(),
                const SizedBox(height: 24),
                _buildDivider(),
                // const SizedBox(height: 24),
                // _buildSocialSignupButtons(),
                // const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Get.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Login',
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

  Widget _buildNameField() {
    return TextField(
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: 'Enter your full name',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
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

  Widget _buildPhoneField() {
    return TextField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: const Icon(Icons.phone_outlined),
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
        hintText: 'Create a password',
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

  Widget _buildSignupButton() {
    return Obx(() => ElevatedButton(
      onPressed: controller.isLoading.value ? null : controller.signup,
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
        'Sign Up',
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
            'Or sign up with',
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

  // Widget _buildSocialSignupButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       _buildSocialButton(
  //         icon: Icons.g_mobiledata,
  //         label: 'Google',
  //         onPressed: () {
  //           // TODO: Implement Google signup
  //         },
  //       ),
  //       _buildSocialButton(
  //         icon: Icons.facebook,
  //         label: 'Facebook',
  //         onPressed: () {
  //           // TODO: Implement Facebook signup
  //         },
  //       ),
  //       _buildSocialButton(
  //         icon: Icons.apple,
  //         label: 'Apple',
  //         onPressed: () {
  //           // TODO: Implement Apple signup
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