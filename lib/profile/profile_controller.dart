import 'package:get/get.dart';

class ProfileController extends GetxController{
  final name = 'John Doe'.obs;
  final email = 'john.doe@example.com'.obs;
  final phone = '+91 9876543210'.obs;
  final dob = '15/05/1990'.obs;
  final address = '123 Main Street, Mumbai, Maharashtra'.obs;
  final occupation = 'Software Engineer'.obs;
  final monthlyIncome = '₹85,000'.obs;
  final kycStatus = 'Verified'.obs;
  final creditScore = 750.obs;

  // Medical Insurance Details
  final insuranceProvider = 'HealthCare Plus'.obs;
  final policyNumber = 'HCP-2024-78901'.obs;
  final coverageAmount = '₹5,00,000'.obs;
  final validUntil = '31/12/2024'.obs;

  // Document Status
  final documentsStatus = <String, bool>{
    'Aadhar Card': true,
    'PAN Card': true,
    'Income Proof': true,
    'Bank Statements': true,
    'Medical Records': false,
  }.obs;

  // Recent Activities
  final recentActivities = <Map<String, String>>[
    {
      'action': 'EMI Payment',
      'date': '01/03/2024',
      'description': 'Successfully paid EMI for March 2024',
    },
    {
      'action': 'Document Upload',
      'date': '25/02/2024',
      'description': 'Updated medical records',
    },
    {
      'action': 'Profile Update',
      'date': '20/02/2024',
      'description': 'Changed contact number',
    },
  ].obs;

  void updateProfile({
    String? newName,
    String? newEmail,
    String? newPhone,
    String? newAddress,
  }) {
    if (newName != null) name.value = newName;
    if (newEmail != null) email.value = newEmail;
    if (newPhone != null) phone.value = newPhone;
    if (newAddress != null) address.value = newAddress;
  }

  void uploadDocument(String documentType) {
    // Simulating document upload
    documentsStatus[documentType] = true;
    recentActivities.insert(0, {
      'action': 'Document Upload',
      'date': DateTime.now().toString().split(' ')[0],
      'description': 'Uploaded $documentType',
    });
  }
}