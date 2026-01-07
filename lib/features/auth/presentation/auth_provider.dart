import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/storage_service.dart';

// Auth durumunu temsil eden basit bir enum
enum AuthStatus { initial, authenticated, unauthenticated }

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(AuthStatus.initial) {
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _ref.read(storageServiceProvider).getToken();
    if (token != null && token.isNotEmpty) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> loginSuccess() async {
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await _ref.read(storageServiceProvider).clearToken();
    state = AuthStatus.unauthenticated;
  }
}
