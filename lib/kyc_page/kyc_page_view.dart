import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/kyc_page/kyc_page_controller.dart';

class KYCPageView extends GetView<KYCController>{
  // Define GlobalKeys for the forms in each step
  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _contactDetailsFormKey = GlobalKey<FormState>();
  // You can add keys for other steps if they require form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('KYC Verification'),
        elevation: 0,
      ),
      body: Obx(() => Stepper(
        type: StepperType.horizontal,
        currentStep: controller.currentStep.value,
        onStepContinue: controller.canProceed() ? controller.nextStep : null,
        onStepCancel: controller.previousStep,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                if (controller.currentStep.value > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Previous'),
                    ),
                  ),
                if (controller.currentStep.value > 0)
                  SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Determine the form key for the current step
                      GlobalKey<FormState>? currentFormKey;
                      if (controller.currentStep.value == 0) {
                        currentFormKey = _personalDetailsFormKey;
                      } else if (controller.currentStep.value == 1) {
                        currentFormKey = _contactDetailsFormKey;
                      }
                      // Add conditions for other steps if they have forms

                      bool isFormValid = true;
                      if (currentFormKey != null) {
                        isFormValid = currentFormKey.currentState!.validate();
                      }

                      // If validation passes or no form exists for the step, proceed
                      if (isFormValid && controller.canProceed()) {
                         details.onStepContinue!();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      controller.currentStep.value == 3 ? 'Submit' : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text('Personal'),
            content: _buildPersonalDetailsForm(),
            isActive: controller.currentStep.value >= 0,
            state: _getStepState(0),
          ),
          Step(
            title: Text('Contact'),
            content: _buildContactDetailsForm(),
            isActive: controller.currentStep.value >= 1,
            state: _getStepState(1),
          ),
          Step(
            title: Text('Nominee'),
            content: _buildNomineeDetailsForm(),
            isActive: controller.currentStep.value >= 2,
            state: _getStepState(2),
          ),
          Step(
            title: Text('Verify'),
            content: _buildFaceVerificationStep(),
            isActive: controller.currentStep.value >= 3,
            state: _getStepState(3),
          ),
        ],
      )),
    );
  }

  StepState _getStepState(int step) {
    if (controller.currentStep.value > step) {
      return StepState.complete;
    }
    if (controller.currentStep.value == step) {
      return StepState.editing;
    }
    return StepState.indexed;
  }

  Widget _buildPersonalDetailsForm() {
    return Form(
      key: _personalDetailsFormKey, // Assign the form key
      child: Column(
        children: [
          _buildTextField(
            label: 'Full Name',
            onChanged: (value) => controller.updatePersonalDetails(name: value),
            value: controller.fullName.value,
          ),
          _buildTextField(
            label: 'Date of Birth',
            onChanged: (value) => controller.updatePersonalDetails(dob: value),
            value: controller.dateOfBirth.value,
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                final date = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  controller.updatePersonalDetails(
                    dob: '${date.day}/${date.month}/${date.year}',
                  );
                }
              },
            ),
          ),
          _buildDropdownField(
            label: 'Gender',
            value: controller.gender.value,
            items: ['Male', 'Female', 'Other'],
            onChanged: (value) => controller.updatePersonalDetails(gender: value),
          ),
          _buildDropdownField(
            label: 'Marital Status',
            value: controller.maritalStatus.value,
            items: ['Single', 'Married', 'Divorced', 'Widowed'],
            onChanged: (value) => controller.updatePersonalDetails(maritalStatus: value),
          ),
          _buildTextField(
            label: 'PAN Number',
            onChanged: (value) => controller.updatePersonalDetails(pan: value),
            value: controller.panNumber.value,
            textCapitalization: TextCapitalization.characters,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter PAN number';
              }
              // PAN format: ABCDE1234F
              if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                return 'Invalid PAN format (e.g., ABCDE1234F)';
              }
              return null;
            },
          ),
          _buildTextField(
            label: 'Aadhar Number',
            onChanged: (value) => controller.updatePersonalDetails(aadhar: value),
            value: controller.aadharNumber.value,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Aadhaar number';
              }
              // Aadhaar format: 12 digits, starting from 2-9
              if (!RegExp(r'^[2-9]{1}[0-9]{11}$').hasMatch(value)) {
                return 'Invalid Aadhaar format (12 digits, starting from 2-9)';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetailsForm() {
    return Form(
      key: _contactDetailsFormKey, // Assign the form key
      child: Column(
        children: [
          _buildTextField(
            label: 'Mobile Number',
            onChanged: (value) => controller.updateContactDetails(mobile: value),
            value: controller.mobileNumber.value,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              // Indian mobile number format: 10 digits, starting from 6-9
              if (!RegExp(r'^[6-9]{1}[0-9]{9}$').hasMatch(value)) {
                return 'Invalid Indian mobile number (10 digits, starting 6-9)';
              }
              return null;
            },
          ),
          _buildTextField(
            label: 'Email Address',
            onChanged: (value) => controller.updateContactDetails(email: value),
            value: controller.emailAddress.value,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            label: 'Permanent Address',
            onChanged: (value) => controller.updateContactDetails(permAddress: value),
            value: controller.permanentAddress.value,
            maxLines: 3,
          ),
          Row(
            children: [
              Obx(() => Checkbox(
                value: controller.sameAsPermAddress.value,
                onChanged: (value) => controller.updateContactDetails(sameAsPermAddr: value),
              )),
              Text('Same as Permanent Address'),
            ],
          ),
          if (!controller.sameAsPermAddress.value)
            _buildTextField(
              label: 'Current Address',
              onChanged: (value) => controller.updateContactDetails(currAddress: value),
              value: controller.currentAddress.value,
              maxLines: 3,
            ),
        ],
      ),
    );
  }

  Widget _buildNomineeDetailsForm() {
    return Column(
      children: [
        _buildTextField(
          label: 'Nominee Full Name',
          onChanged: (value) => controller.updateNomineeDetails(name: value),
          value: controller.nomineeFullName.value,
        ),
        _buildTextField(
          label: 'Relationship with Nominee',
          onChanged: (value) => controller.updateNomineeDetails(relation: value),
          value: controller.nomineeRelation.value,
        ),
        _buildTextField(
          label: 'Nominee Date of Birth',
          onChanged: (value) => controller.updateNomineeDetails(dob: value),
          value: controller.nomineeDateOfBirth.value,
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                controller.updateNomineeDetails(
                  dob: '${date.day}/${date.month}/${date.year}',
                );
              }
            },
          ),
        ),
        _buildTextField(
          label: 'Nominee Address',
          onChanged: (value) => controller.updateNomineeDetails(address: value),
          value: controller.nomineeAddress.value,
          maxLines: 3,
        ),
        _buildTextField(
          label: 'Nominee Phone Number',
          onChanged: (value) => controller.updateNomineeDetails(phone: value),
          value: controller.nomineePhone.value,
          keyboardType: TextInputType.phone,
        ),
        _buildTextField(
          label: 'Nominee Email',
          onChanged: (value) => controller.updateNomineeDetails(email: value),
          value: controller.nomineeEmail.value,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildFaceVerificationStep() {
    return Column(
      children: [
        Container(
          height: 300,
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.grey[900],
                    // TODO: Implement camera preview here
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _getFaceTrackingColor(),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.black54,
                  child: Obx(() => Text(
                    controller.faceTrackingMessage.value,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ],
          ),
        ),
        _buildFaceTrackingStatus(),
      ],
    );
  }

  Color _getFaceTrackingColor() {
    if (!controller.isFaceDetected.value) return Colors.red;
    if (!controller.isFaceCentered.value) return Colors.orange;
    if (!controller.isLightingGood.value) return Colors.yellow;
    if (controller.faceConfidenceScore.value < 0.8) return Colors.blue;
    return Colors.green;
  }

  Widget _buildFaceTrackingStatus() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatusRow(
              'Face Detection',
              controller.isFaceDetected.value,
            ),
            _buildStatusRow(
              'Face Centered',
              controller.isFaceCentered.value,
            ),
            _buildStatusRow(
              'Good Lighting',
              controller.isLightingGood.value,
            ),
            Obx(() => LinearProgressIndicator(
              value: controller.faceConfidenceScore.value,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                controller.faceConfidenceScore.value >= 0.8
                    ? Colors.green
                    : Colors.orange,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Icon(
            status ? Icons.check_circle : Icons.error_outline,
            color: status ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required String value,
    TextInputType? keyboardType,
    int? maxLines,
    Widget? suffixIcon,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: suffixIcon,
        ),
        controller: TextEditingController(text: value)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: value.length),
          ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        textCapitalization: textCapitalization,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        value: value.isEmpty ? null : value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}