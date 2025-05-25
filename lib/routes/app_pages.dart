import 'package:get/get.dart';
import 'package:ri_medicare/appointment/appointment_binding.dart';
import 'package:ri_medicare/appointment/appointment_view.dart';
import 'package:ri_medicare/auth/auth_binding.dart';
import 'package:ri_medicare/auth/login_view.dart';
import 'package:ri_medicare/auth/sign_up_view.dart';
import 'package:ri_medicare/dashboard/dashboard_binding.dart';
import 'package:ri_medicare/dashboard/dashboard_view.dart';
import 'package:ri_medicare/health_card/health_card_binding.dart';
import 'package:ri_medicare/health_card/health_card_view.dart';
import 'package:ri_medicare/home/home_binding.dart';
import 'package:ri_medicare/home/home_view.dart';
import 'package:ri_medicare/my_loans/my_loans_binding.dart';
import 'package:ri_medicare/my_loans/my_loans_view.dart';
import 'package:ri_medicare/overview/overview_binding.dart';
import 'package:ri_medicare/overview/overview_view.dart';

import 'app_routes.dart';


class AppPages{
  AppPages._();

  static const INITIAL = Routes.dashboard;

  static final routes = [
    GetPage(
        name: Paths.LOGIN,
        page: () => LoginView(),
      binding: AuthBinding()
    ),
    GetPage(
        name: Paths.SIGNUP,
        page: () => SignupView(),
      binding: AuthBinding()
    ),
    GetPage(
      name: Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding()
    ),
    GetPage(
      name: Paths.APPOINTMENT,
      page: () => const AppointmentView(),
      binding: AppointmentBinding()
    ),
    GetPage(
      name: Paths.DASHBOARD,
      page: () => OverViewPage(),
      binding: OverViewBinding()
    ),
    GetPage(
      name: Paths.HEALTHCARD,
      page: () => HealthCardView(),
      binding: HealthCardBinding()
    ),
    GetPage(
      name: Paths.MYLOANS,
      page: () => MyLoansView(),
      binding: MyLoansBinding()
    ),

  ];

}