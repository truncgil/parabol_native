import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';
import '../data/auth_models.dart';
import '../../../core/storage/storage_service.dart';
import 'auth_provider.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // Initial state is void (idle)
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final response = await repository.login(LoginRequest(email: email, password: password));
      
      if (response.success && response.data != null) {
         await ref.read(storageServiceProvider).setToken(response.data!.token);
         // Auth durumunu güncelle
         ref.read(authStateProvider.notifier).loginSuccess();
         state = const AsyncData(null);
      } else {
         throw Exception('Giriş başarısız: Geçersiz yanıt.');
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
