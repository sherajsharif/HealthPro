import 'package:get/get.dart';
import 'package:ri_medicare/health_card/payment/payment_controller.dart';

class PaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }

}