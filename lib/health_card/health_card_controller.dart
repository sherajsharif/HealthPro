import 'package:get/get.dart';

class HealthCardController extends GetxController{
  final cardNumber = 'HC-78901-23456'.obs;
  final expiryDate = '31/12/2026'.obs;
  final isActive = true.obs;
  final availableBalance = 25000.0.obs;
  final usedCredit = 15000.0.obs;
  final totalCreditLimit = 40000.0.obs;

  double get creditUtilization => (usedCredit.value / totalCreditLimit.value) * 100;
}