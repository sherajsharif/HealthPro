import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthCardTabController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}