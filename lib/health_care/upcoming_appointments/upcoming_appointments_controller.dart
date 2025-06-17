import 'package:get/get.dart';
import 'package:ri_medicare/models/appointment_model.dart';

class UpcomingAppointmentController extends GetxController{
  // Upcoming Appointments
  final upcomingAppointments = <Appointment>[
    Appointment(
      date: '10/12/2023',
      time: '10:30 AM',
      hospital: 'City General Hospital',
      doctor: 'Dr. Sarah Johnson',
      department: 'Cardiology',
      type: 'Follow-up check-up',
      status: 'Confirmed',
    ),
    Appointment(
      date: '18/12/2023',
      time: '02:00 PM',
      hospital: 'Wellness Clinic',
      doctor: 'Dr. Amit Patel',
      department: 'Orthopedics',
      type: 'Knee therapy session',
      status: 'Scheduled',
    ),
  ].obs;
}