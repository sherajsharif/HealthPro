import 'package:get/get.dart';
import 'package:ri_medicare/models/appointment_model.dart';

class HospitalVisitController extends GetxController{

  // Hospital Visit History
  final visitHistory = <HospitalVisit>[
    HospitalVisit(
      date: '20/11/2023',
      hospital: 'City General Hospital',
      doctor: 'Dr. Sarah Johnson',
      department: 'Cardiology',
      amount: 3500,
    ),
    HospitalVisit(
      date: '15/10/2023',
      hospital: 'Medicare Pharmacy',
      doctor: 'Dr. Robert Smith',
      department: 'General Medicine',
      amount: 1800,
    ),
    HospitalVisit(
      date: '05/09/2023',
      hospital: 'Wellness Clinic',
      doctor: 'Dr. Amit Patel',
      department: 'Orthopedics',
      amount: 2500,
    ),
    HospitalVisit(
      date: '10/08/2023',
      hospital: 'City General Hospital',
      doctor: 'Dr. Mary Wilson',
      department: 'ENT',
      amount: 1200,
    ),
  ].obs;

  void rescheduleAppointment(int index) {
    // Implement rescheduling logic
  }

  void cancelAppointment(int index) {
    // Implement cancellation logic
  }

  void bookNewAppointment() {
    // Implement booking logic
  }
}