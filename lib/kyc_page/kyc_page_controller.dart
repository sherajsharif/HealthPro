import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class KYCController extends GetxController{
  // Personal Details
  final fullName = ''.obs;
  final dateOfBirth = ''.obs;
  final gender = ''.obs;
  final maritalStatus = ''.obs;
  final panNumber = ''.obs;
  final aadharNumber = ''.obs;

  // Contact Details
  final mobileNumber = ''.obs;
  final emailAddress = ''.obs;
  final permanentAddress = ''.obs;
  final currentAddress = ''.obs;
  final sameAsPermAddress = false.obs;

  // Nominee Details
  final nomineeFullName = ''.obs;
  final nomineeRelation = ''.obs;
  final nomineeDateOfBirth = ''.obs;
  final nomineeAddress = ''.obs;
  final nomineePhone = ''.obs;
  final nomineeEmail = ''.obs;
  final nomineeShare = 100.obs;

  // Face Tracking Status
  final isFaceDetected = false.obs;
  final isFaceCentered = false.obs;
  final isLightingGood = false.obs;
  final faceTrackingMessage = 'Position your face within the frame'.obs;
  final faceConfidenceScore = 0.0.obs;

  // Form Progress
  final currentStep = 0.obs;
  final isPersonalDetailsComplete = false.obs;
  final isContactDetailsComplete = false.obs;
  final isNomineeDetailsComplete = false.obs;
  final isFaceVerificationComplete = false.obs;

  // Document Upload Status
  final documentStatus = <String, bool>{
    'Pan Card': false,
    'Aadhar Card': false,
    'Signature': false,
    'Profile Photo': false,
  }.obs;

  void updatePersonalDetails({
    String? name,
    String? dob,
    String? gender,
    String? maritalStatus,
    String? pan,
    String? aadhar,
  }) {
    if (name != null) fullName.value = name;
    if (dob != null) dateOfBirth.value = dob;
    if (gender != null) this.gender.value = gender;
    if (maritalStatus != null) this.maritalStatus.value = maritalStatus;
    if (pan != null) panNumber.value = pan;
    if (aadhar != null) aadharNumber.value = aadhar;

    validatePersonalDetails();
  }

  void updateContactDetails({
    String? mobile,
    String? email,
    String? permAddress,
    String? currAddress,
    bool? sameAsPermAddr,
  }) {
    if (mobile != null) mobileNumber.value = mobile;
    if (email != null) emailAddress.value = email;
    if (permAddress != null) permanentAddress.value = permAddress;
    if (currAddress != null) currentAddress.value = currAddress;
    if (sameAsPermAddr != null) {
      sameAsPermAddress.value = sameAsPermAddr;
      if (sameAsPermAddr) {
        currentAddress.value = permanentAddress.value;
      }
    }

    validateContactDetails();
  }

  void updateNomineeDetails({
    String? name,
    String? relation,
    String? dob,
    String? address,
    String? phone,
    String? email,
    int? share,
  }) {
    if (name != null) nomineeFullName.value = name;
    if (relation != null) nomineeRelation.value = relation;
    if (dob != null) nomineeDateOfBirth.value = dob;
    if (address != null) nomineeAddress.value = address;
    if (phone != null) nomineePhone.value = phone;
    if (email != null) nomineeEmail.value = email;
    if (share != null) nomineeShare.value = share;

    validateNomineeDetails();
  }

  void updateFaceTrackingStatus({
    bool? detected,
    bool? centered,
    bool? goodLighting,
    double? confidence,
  }) {
    if (detected != null) isFaceDetected.value = detected;
    if (centered != null) isFaceCentered.value = centered;
    if (goodLighting != null) isLightingGood.value = goodLighting;
    if (confidence != null) faceConfidenceScore.value = confidence;

    _updateFaceTrackingMessage();
    validateFaceVerification();
  }

  void _updateFaceTrackingMessage() {
    if (!isFaceDetected.value) {
      faceTrackingMessage.value = 'No face detected. Please position your face within the frame';
    } else if (!isFaceCentered.value) {
      faceTrackingMessage.value = 'Please center your face in the frame';
    } else if (!isLightingGood.value) {
      faceTrackingMessage.value = 'Please move to a well-lit area';
    } else if (faceConfidenceScore.value < 0.8) {
      faceTrackingMessage.value = 'Please keep your face steady';
    } else {
      faceTrackingMessage.value = 'Perfect! Capturing your photo...';
    }
  }

  void validatePersonalDetails() {
    isPersonalDetailsComplete.value =
        fullName.value.isNotEmpty &&
            dateOfBirth.value.isNotEmpty &&
            gender.value.isNotEmpty &&
            maritalStatus.value.isNotEmpty &&
            panNumber.value.isNotEmpty &&
            aadharNumber.value.isNotEmpty;
  }

  void validateContactDetails() {
    isContactDetailsComplete.value =
        mobileNumber.value.isNotEmpty &&
            emailAddress.value.isNotEmpty &&
            permanentAddress.value.isNotEmpty &&
            currentAddress.value.isNotEmpty;
  }

  void validateNomineeDetails() {
    isNomineeDetailsComplete.value =
        nomineeFullName.value.isNotEmpty &&
            nomineeRelation.value.isNotEmpty &&
            nomineeDateOfBirth.value.isNotEmpty &&
            nomineeAddress.value.isNotEmpty &&
            nomineePhone.value.isNotEmpty;
  }

  void validateFaceVerification() {
    isFaceVerificationComplete.value =
        isFaceDetected.value &&
            isFaceCentered.value &&
            isLightingGood.value &&
            faceConfidenceScore.value >= 0.8;
  }

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  bool canProceed() {
    switch (currentStep.value) {
      case 0:
        return isPersonalDetailsComplete.value;
      case 1:
        return isContactDetailsComplete.value;
      case 2:
        return isNomineeDetailsComplete.value;
      case 3:
        return isFaceVerificationComplete.value;
      default:
        return false;
    }
  }
}