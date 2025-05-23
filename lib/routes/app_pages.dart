import 'package:get/get.dart';
import 'package:ri_medicare/home/home_view.dart';

import 'app_routes.dart';


class AppPages{
  AppPages._();

  static const INITIAL = Routes.home;

  static final routes = [
    GetPage(
      name: Paths.HOME,
      page: () => const HomeView(),

    )
  ];

}