import 'package:get/get.dart';
import 'package:ri_medicare/appointment/appointment_controller.dart';
import 'package:ri_medicare/dashboard/dashboard_controller.dart';
import 'package:ri_medicare/health_card/health_card_tab/health_card_tab_controller.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_controller.dart';
import 'package:ri_medicare/health_card/payment/payment_controller.dart';
import 'package:ri_medicare/health_card/transactions/transaction_controller.dart';
import 'package:ri_medicare/health_care/health_care_tab/healthcare_tab_controller.dart';
import 'package:ri_medicare/health_care/hospital_visits/hospital_visits_controller.dart';
import 'package:ri_medicare/health_care/upcoming_appointments/upcoming_appointments_controller.dart';
import 'package:ri_medicare/home/home_controller.dart';
import 'package:ri_medicare/kyc_page/kyc_page_controller.dart';
import 'package:ri_medicare/my_loans/my_loans_controller.dart';
import 'package:ri_medicare/overview/overview_controller.dart';
import 'package:ri_medicare/profile/profile_binding.dart';
import 'package:ri_medicare/profile/profile_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AppointmentController());
    Get.put(OverViewController(), permanent: true);
    Get.lazyPut(() => HealthCardTabController());
    Get.lazyPut(() => MyLoansController());
    Get.lazyPut(() => HospitalVisitController());
    Get.lazyPut(() => HealthCareTabController());
    Get.lazyPut(() => HeathCardOverviewController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => PaymentController());
    Get.lazyPut(() => UpcomingAppointmentController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => KYCController());
  }

}