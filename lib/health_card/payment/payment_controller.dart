import 'package:get/get.dart';
import 'package:ri_medicare/models/upcoming_payement_model.dart';

class PaymentController extends GetxController{
  final upcomingPayments = <UpcomingPayment>[
    UpcomingPayment(
      dueDate: '15/12/2023',
      description: 'EMI for Health Procedure',
      amount: 2000,
      status: 'Upcoming',
    ),
    UpcomingPayment(
      dueDate: '15/01/2024',
      description: 'EMI for Health Procedure',
      amount: 2000,
      status: 'Upcoming',
    ),
    UpcomingPayment(
      dueDate: '15/02/2024',
      description: 'EMI for Health Procedure',
      amount: 2000,
      status: 'Upcoming',
    ),
  ].obs;

  final isAutoDebitEnabled = false.obs;


  void setUpAutoDebit() {
    // Implement auto-debit setup logic
    isAutoDebitEnabled.value = true;
  }

  void payNow(int index) {
    // Implement payment logic
  }

  void setReminders() {
    // Implement reminder setup logic
  }
}