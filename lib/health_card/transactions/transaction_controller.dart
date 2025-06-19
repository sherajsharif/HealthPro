import 'package:get/get.dart';
import 'package:ri_medicare/models/transaction_model.dart';

class TransactionController extends GetxController{
  final selectedTransactionTab = 0.obs;
  final transactions = <Transaction>[
    Transaction(
      date: '22/11/2023',
      hospital: 'City General Hospital',
      service: 'Consultation',
      amount: 2500,
      status: 'Completed',
    ),
    Transaction(
      date: '15/11/2023',
      hospital: 'Medicare Pharmacy',
      service: 'Medication',
      amount: 1800,
      status: 'Completed',
    ),
    Transaction(
      date: '10/11/2023',
      hospital: 'City General Hospital',
      service: 'Lab Tests',
      amount: 3500,
      status: 'Completed',
    ),
    Transaction(
      date: '05/11/2023',
      hospital: 'Wellness Clinic',
      service: 'Physiotherapy',
      amount: 1200,
      status: 'Completed',
    ),
  ].obs;


  void changeTransactionTab(int index) {
    selectedTransactionTab.value = index;
  }

  void filterTransactions() {
    // Implement filter logic
  }

  void exportTransactions() {
    // Implement export logic
  }

  void viewTransactionDetails(int index) {
    // Implement view details logic
  }
}