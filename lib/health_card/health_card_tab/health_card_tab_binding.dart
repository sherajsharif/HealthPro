import 'package:get/get.dart';
import 'package:ri_medicare/health_card/health_card_tab/health_card_tab_controller.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_controller.dart';
import 'package:ri_medicare/health_card/payment/payment_controller.dart';
import 'package:ri_medicare/health_card/transactions/transaction_controller.dart';

class HealthCardTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HealthCardTabController());
    Get.lazyPut(() => TransactionController());
  }

}