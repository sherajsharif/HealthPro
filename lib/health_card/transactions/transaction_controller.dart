import 'package:get/get.dart';
import 'package:ri_medicare/models/transaction_model.dart';
import 'package:ri_medicare/services/transaction_service.dart';

class TransactionController extends GetxController {
  final selectedTransactionTab = 0.obs;
  final transactions = <Transaction>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  final TransactionService _transactionService = TransactionService();

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      error.value = null;
      final txs = await _transactionService.getUserTransactions();
      transactions.assignAll(txs);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

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