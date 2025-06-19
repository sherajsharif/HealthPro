import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/appointment/appointment_binding.dart';
import 'package:ri_medicare/appointment/appointment_view.dart';
import 'package:ri_medicare/auth/auth_binding.dart';
import 'package:ri_medicare/auth/auth_controller.dart';
import 'package:ri_medicare/auth/login_page.dart';
import 'package:ri_medicare/dashboard/dashboard_binding.dart';
import 'package:ri_medicare/dashboard/dashboard_view.dart';
import 'package:ri_medicare/health_card/health_card_tab/health_card_tab_binding.dart';
import 'package:ri_medicare/health_card/health_card_tab/health_card_tab_view.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_binding.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_view.dart';
import 'package:ri_medicare/health_card/payment/payment_binding.dart';
import 'package:ri_medicare/health_card/payment/payment_view.dart';
import 'package:ri_medicare/health_card/transactions/transaction_binding.dart';
import 'package:ri_medicare/health_card/transactions/transaction_view.dart';
import 'package:ri_medicare/health_care/health_care_tab/healthcare_tab_view.dart';
import 'package:ri_medicare/health_care/hospital_visits/hospital_visits_binding.dart';
import 'package:ri_medicare/health_care/hospital_visits/hospital_visits_view.dart';
import 'package:ri_medicare/health_care/upcoming_appointments/upcoming_appointments_binding.dart';
import 'package:ri_medicare/health_care/upcoming_appointments/upcoming_appointments_view.dart';
import 'package:ri_medicare/home/home_binding.dart';
import 'package:ri_medicare/home/home_view.dart';
import 'package:ri_medicare/kyc_page/kyc_page_view.dart';
import 'package:ri_medicare/my_loans/my_loans_binding.dart';
import 'package:ri_medicare/my_loans/my_loans_view.dart';
import 'package:ri_medicare/overview/overview_view.dart';
import 'package:ri_medicare/profile/profile_view.dart';
import 'package:ri_medicare/auth/registration_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.APPOINTMENT,
      page: () => const AppointmentView(),
      binding: AppointmentBinding()
    ),
    GetPage(
      name: Routes.OVERVIEW,
      page: () => OverViewPage(),
    ),
    GetPage(
      name: Routes.HEALTHCARDTAB,
      page: () => HealthCardTabView(),
    ),
    GetPage(
      name: Routes.MYLOANS,
      page: () => MyLoansView(),
      binding: MyLoansBinding()
    ),
    GetPage(
      name: Routes.HOSPITALVISITS,
      page: () => HospitalVisitView(),
      binding: HospitalVisitsBinding()
    ),
    GetPage(
      name: Routes.UPCOMINGAPPOINTMENT,
      page: () => UpcomingAppointmentView(),
      binding: UpcomingAppointmentBinding()
    ),
    GetPage(
      name: Routes.HEALTHCARE,
      page: () => HealthCareTabView(),
    ),
    GetPage(
      name: Routes.HEALTHCARDOVERVIEW,
      page: () => HealthCardOverviewView(),
      binding: HealthCardOverviewBinding()
    ),
    GetPage(
      name: Routes.TRANSACTIONS,
      page: () => TransactionView(),
      binding: TransactionBinding()
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding()
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: Routes.KYCPAGE,
      page: () => KYCPageView(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegistrationScreen(),
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    if (!authController.isLoggedIn) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}