import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<Map<String, dynamic>> nearbyHospitals = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> nearbyDoctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNearbyHospitals();
    loadNearbyDoctors();
  }

  void loadNearbyHospitals() {
    // Simulated data - In a real app, this would come from an API
    nearbyHospitals.value = [
      {
        'name': 'City General Hospital',
        'distance': '2.5 km',
        'rating': 4.5,
        'image': 'assets/images/hospital1.jpg',
      },
      {
        'name': 'Medicare Center',
        'distance': '3.1 km',
        'rating': 4.3,
        'image': 'assets/images/hospital2.jpg',
      },
      {
        'name': 'City General Hospital',
        'distance': '2.5 km',
        'rating': 4.5,
        'image': 'assets/images/hospital1.jpg',
      },
      {
        'name': 'Medicare Center',
        'distance': '3.1 km',
        'rating': 4.3,
        'image': 'assets/images/hospital2.jpg',
      },
    ];
  }

  void loadNearbyDoctors() {
    // Simulated data - In a real app, this would come from an API
    nearbyDoctors.value = [
      {
        'name': 'Dr. John Smith',
        'specialty': 'Cardiologist',
        'experience': '15 years',
        'rating': 4.8,
        'image': 'assets/images/doctor1.jpg',
      },
      {
        'name': 'Dr. Sarah Johnson',
        'specialty': 'Pediatrician',
        'experience': '10 years',
        'rating': 4.6,
        'image': 'assets/images/doctor2.jpg',
      },
    ];
  }
}