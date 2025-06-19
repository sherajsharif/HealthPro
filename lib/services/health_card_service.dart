import 'package:get/get.dart';
import '../models/health_card.dart';
import 'api_service.dart';

class HealthCardService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<List<HealthCard>> getUserHealthCards() async {
    final response = await _apiService.get('/health-cards');
    return (response as List).map((json) => HealthCard.fromJson(json)).toList();
  }

  Future<HealthCard> getHealthCardById(String id) async {
    final response = await _apiService.get('/health-cards/$id');
    return HealthCard.fromJson(response);
  }

  Future<HealthCard> createHealthCard({
    required String cardNumber,
    required String userId,
    required DateTime expiryDate,
    double? availableCredit,
  }) async {
    final data = {
      'cardNumber': cardNumber,
      'userId': userId,
      'expiryDate': expiryDate.toIso8601String(),
      if (availableCredit != null) 'availableCredit': availableCredit,
    };

    final response = await _apiService.post('/health-cards', data);
    return HealthCard.fromJson(response);
  }
}