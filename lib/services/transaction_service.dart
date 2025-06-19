import 'package:get/get.dart';
import '../models/transaction_model.dart';
import 'api_service.dart';

class TransactionService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<List<Transaction>> getUserTransactions() async {
    final response = await _apiService.get('/transactions');
    return (response as List).map((json) => Transaction.fromJson(json)).toList();
  }
} 