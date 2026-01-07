import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/network_manager.dart';
import 'auth_models.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(ref.read(dioProvider)));

class AuthRepository {
  final Dio _dio;
  AuthRepository(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      // Assuming standard Laravel Passport/Sanctum or similar
      final response = await _dio.post('/auth/login', data: request.toJson());
      // Adjust path if needed based on real docs
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
