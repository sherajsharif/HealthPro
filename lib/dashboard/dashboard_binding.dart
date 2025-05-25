import 'package:get/get.dart';
import 'package:ri_medicare/appointment/appointment_controller.dart';
import 'package:ri_medicare/dashboard/dashboard_controller.dart';
import 'package:ri_medicare/health_card/health_card_controller.dart';
import 'package:ri_medicare/home/home_controller.dart';
import 'package:ri_medicare/my_loans/my_loans_controller.dart';
import 'package:ri_medicare/overview/overview_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AppointmentController());
    Get.lazyPut(() => OverViewController());
    Get.lazyPut(() => HealthCardController());
    Get.lazyPut(() => MyLoansController());
  }

}