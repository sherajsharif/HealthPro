import 'package:get/get.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_controller.dart';

class HealthCardOverviewBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => HeathCardOverviewController());
  }

}