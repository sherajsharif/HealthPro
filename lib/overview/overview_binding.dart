import 'package:get/get.dart';
import 'package:ri_medicare/overview/overview_controller.dart';

class OverViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OverViewController());
  }
}