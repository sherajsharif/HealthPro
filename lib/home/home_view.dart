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
            _buildHeader(),
            _buildSearchBar(),
            _buildFeatureGrid(),
            _buildNearbySection(context),
          ],
        ),
      ),
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
            child: Icon(Icons.person_2_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search doctors, hospitals...',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Get.theme.primaryColor),
        ),
      ),
    );
  }

  Widget _buildFeatureGrid() {
    final features = [
      {'icon': Icons.local_hospital, 'title': 'Hospitals'},
      {'icon': Icons.person, 'title': 'Doctors'},
      {'icon': Icons.calendar_today, 'title': 'Appointments'},
      {'icon': Icons.medical_services, 'title': 'Tests'},
      {'icon': Icons.medication, 'title': 'Medicine'},
      {'icon': Icons.description, 'title': 'Health Cards'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _buildFeatureItem(
          features[index]['icon'] as IconData,
          features[index]['title'] as String,
        );
      },
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Get.theme.primaryColor),
          const SizedBox(height: 8),
          Text(
            title,
            style: Get.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNearbySection(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nearby Hospitals',
              style: Get.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Obx(() => SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.nearbyHospitals.length,
                itemBuilder: (context, index) {
                  final hospital = controller.nearbyHospitals[index];
                  return _buildHospitalCard(hospital, context);
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalCard(Map<String, dynamic> hospital, context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.45,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              hospital['image'],
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital['name'],
                  style: Get.textTheme.titleMedium,
                ),
                Text(
                  hospital['distance'],
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
