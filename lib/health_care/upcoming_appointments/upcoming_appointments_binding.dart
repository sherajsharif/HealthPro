import 'package:get/get.dart';
import 'package:ri_medicare/health_care/upcoming_appointments/upcoming_appointments_controller.dart';

class UpcomingAppointmentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UpcomingAppointmentController());
  }
}