import 'package:get/get.dart';
import 'package:ri_medicare/models/emi_payment.dart';

class MyLoansController extends GetxController{
  final cardNumber = 'HC-78901-23456'.obs;
  final expiryDate = '31/12/2026'.obs;
  final isActive = true.obs;
  final availableBalance = 25000.0.obs;
  final usedCredit = 15000.0.obs;
  final totalCreditLimit = 40000.0.obs;

  double get creditUtilization => (usedCredit.value / totalCreditLimit.value) * 100;

  // Loan Details
  final loanId = 'LOAN-123456'.obs;
  final totalLoanAmount = 50000.0.obs;
  final remainingBalance = 35000.0.obs;
  final monthlyEMI = 2500.0.obs;
  final interestRate = 12.0.obs;
  final loanTerm = 24.obs;
  final nextPaymentDue = '15/12/2023'.obs;
  final loanProgress = 50.0.obs;

  // EMI Payment History
  final paymentHistory = <EMIPayment>[
    EMIPayment(
      emiNumber: 11,
      dueDate: '15/11/2023',
      totalAmount: 2500,
      principal: 1800,
      interest: 700,
      isPaid: true,
      paymentDate: '14/11/2023',
    ),
    EMIPayment(
      emiNumber: 10,
      dueDate: '15/10/2023',
      totalAmount: 2500,
      principal: 1780,
      interest: 720,
      isPaid: true,
      paymentDate: '15/10/2023',
    ),
    EMIPayment(
      emiNumber: 9,
      dueDate: '15/09/2023',
      totalAmount: 2500,
      principal: 1760,
      interest: 740,
      isPaid: true,
      paymentDate: '13/09/2023',
    ),
    EMIPayment(
      emiNumber: 8,
      dueDate: '15/08/2023',
      totalAmount: 2500,
      principal: 1740,
      interest: 760,
      isPaid: true,
      paymentDate: '15/08/2023',
    ),
  ].obs;
}