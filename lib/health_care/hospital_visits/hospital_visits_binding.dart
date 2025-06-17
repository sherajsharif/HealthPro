import 'package:get/get.dart';
import 'package:ri_medicare/health_care/hospital_visits/hospital_visits_controller.dart';

class HospitalVisitsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HospitalVisitController());
  }

}