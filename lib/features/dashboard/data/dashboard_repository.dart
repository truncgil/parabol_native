import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/network_manager.dart';
import 'dashboard_models.dart';

final dashboardRepositoryProvider = Provider((ref) => DashboardRepository(ref.read(dioProvider)));

class DashboardRepository {
  final Dio _dio;
  DashboardRepository(this._dio);

  Future<List<Account>> getAccounts() async {
    final response = await _dio.get('/accounts');
    print('API Response Raw Data: ${response.data}');
    
    final result = AccountResponse.fromJson(response.data);
    return result.data;
  }

  Future<List<Transaction>> getTransactions(
    int accountId, {
    int page = 1,
    int limit = 15,
    String sort = 'paid_at',
  }) async {
    final response = await _dio.get(
      '/transactions',
      queryParameters: {
        'account_id': accountId,
        'page': page,
        'limit': limit,
        'sort': sort,
      },
    );
    final result = TransactionResponse.fromJson(response.data);
    return result.data;
  }
}
