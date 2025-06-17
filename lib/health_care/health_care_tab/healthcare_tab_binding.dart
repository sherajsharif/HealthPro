import 'package:get/get.dart';
import 'package:ri_medicare/health_care/health_care_tab/healthcare_tab_controller.dart';
import 'package:ri_medicare/health_care/upcoming_appointments/upcoming_appointments_controller.dart';

class HealthCareTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HealthCareTabController());
  }

}