import 'package:get/get.dart';
import 'package:ri_medicare/appointment/appointment_controller.dart';

class AppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppointmentController());
  }
}