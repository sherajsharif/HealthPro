import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader()
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, User',
                style: Get.textTheme.bodyLarge,
              ),
              Text(
                'Find Your Medical Care',
                style: Get.textTheme.displayLarge,
              ),
            ],
          ),
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
        ],
      ),
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
