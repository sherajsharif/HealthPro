import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/appointment/appointment_view.dart';
import 'package:ri_medicare/health_care/health_care_tab/healthcare_tab_controller.dart';
import 'package:ri_medicare/health_care/hospital_visits/hospital_visits_view.dart';
import 'package:ri_medicare/health_care/upcoming_appointments/upcoming_appointments_view.dart';

class HealthCareTabView extends GetView<HealthCareTabController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 14, right: 14, top: 20),
            padding: const EdgeInsets.all(5),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: controller.tabController,
              labelColor: Colors.deepPurple,
              unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
              unselectedLabelColor:  Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              labelStyle: TextStyle(color: Colors.deepPurple[200], fontSize: 14, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              tabs: [
                Tab(
                  text: 'Appointments',
                ),
                Tab(
                  text: 'Hospital Visits',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                UpcomingAppointmentView(),
                HospitalVisitView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}