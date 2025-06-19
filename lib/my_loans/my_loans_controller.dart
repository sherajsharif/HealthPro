import 'package:get/get.dart';
import 'package:ri_medicare/models/emi_payments.dart';
import 'package:ri_medicare/models/loan_model.dart';
import 'package:ri_medicare/services/api_service.dart';

class MyLoansController extends GetxController{
  final cardNumber = 'HC-78901-23456'.obs;
  final expiryDate = '31/12/2026'.obs;
  final isActive = true.obs;
  final availableBalance = 25000.0.obs;
  final usedCredit = 15000.0.obs;
  final totalCreditLimit = 40000.0.obs;
  final paymentHistory = <EMIPayment>[].obs;
  final loans = <Loan>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  double get creditUtilization => (usedCredit.value / totalCreditLimit.value) * 100;

  @override
  void onInit() {
    super.onInit();
    loadPaymentHistory();
    fetchLoans();
  }


  // Loan Details
  final loanId = 'LOAN-123456'.obs;
  final totalLoanAmount = 50000.0.obs;
  final remainingBalance = 35000.0.obs;
  final monthlyEMI = 2500.0.obs;
  final interestRate = 12.0.obs;
  final loanTerm = 24.obs;
  final nextPaymentDue = '15/12/2023'.obs;
  final loanProgress = 50.0.obs;

  void loadPaymentHistory() {
    paymentHistory.value = [
      EMIPayment(
        emiNumber: 1,
        dueDate: '01/03/2024',
        totalAmount: 5000,
        principal: 4200,
        interest: 800,
        status: 'Paid',
        paymentDate: '01/03/2024',
      ),
      EMIPayment(
        emiNumber: 2,
        dueDate: '01/04/2024',
        totalAmount: 5000,
        principal: 4300,
        interest: 700,
        status: 'Pending',
        paymentDate: '-',
      ),
      EMIPayment(
        emiNumber: 3,
        dueDate: '01/05/2024',
        totalAmount: 5000,
        principal: 4400,
        interest: 600,
        status: 'Upcoming',
        paymentDate: '-',
      ),
    ];
  }

  Future<void> fetchLoans() async {
    try {
      isLoading.value = true;
      error.value = null;
      final apiService = Get.find<ApiService>();
      final response = await apiService.get('/loans');
      loans.assignAll((response as List).map((e) => Loan.fromJson(e)).toList());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}