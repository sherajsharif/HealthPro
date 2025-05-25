import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/dashboard/dashboard_controller.dart';
import 'package:ri_medicare/health_card/health_card_view.dart';
import 'package:ri_medicare/my_loans/my_loans_view.dart';
import 'package:ri_medicare/overview/overview_view.dart';

class DashboardView extends GetView<DashboardController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            OverViewPage(),
            HealthCardView(),
            MyLoansView(),
          ],
        ),)
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        selectedItemColor: Get.theme.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ]
    )
    );
  }

}