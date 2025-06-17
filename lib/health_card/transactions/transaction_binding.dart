import 'package:get/get.dart';
import 'package:ri_medicare/health_card/transactions/transaction_controller.dart';

class TransactionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController());
  }
}