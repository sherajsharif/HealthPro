import 'package:get/get.dart';
import 'package:ri_medicare/health_card/health_card_controller.dart';

class HealthCardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HealthCardController());
  }

}