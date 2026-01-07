import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/auth_provider.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/dashboard/presentation/main_wrapper.dart';
import '../../features/products/presentation/products_screen.dart';
import '../../features/bank/presentation/bank_screen.dart';
import '../../features/menu/presentation/menu_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  // Auth durumunu dinle (değiştiğinde router'ın haberi olması için stream/listenable gerekebilir ama
  // burada basitçe redirect içinde okuyacağız. Gerçek reaktiflik için GoRouterRefreshStream kullanılabilir.)
  // Basitlik için: AuthStatus değiştiğinde router'ın redirect'i tetiklenmeli.
  
  final authStatus = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/', // Varsayılan olarak ana sayfaya gitmeye çalış
    redirect: (context, state) {
      final authStatus = ref.read(authStateProvider);
      final isLoggedIn = authStatus == AuthStatus.authenticated;
      final isLoggingIn = state.uri.toString() == '/login';

      // Eğer başlangıç durumundaysak (token kontrol ediliyor) bekleyebiliriz veya loading gösterebiliriz.
      // Şimdilik unauthenticated kabul edip login'e atalım, authenticated ise geçsin.
      if (authStatus == AuthStatus.initial) return null; // Henüz belli değilse bir şey yapma (Splash olabilir)

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },
    // Bu kısım önemli: AuthState değiştiğinde Router'ın yeniden değerlendirmesi (refresh) yapması için
    refreshListenable: AuthListenable(ref), 
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/products',
                builder: (context, state) => const ProductsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bank',
                builder: (context, state) => const BankScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/menu',
                builder: (context, state) => const MenuScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

// Riverpod state'ini GoRouter'ın anlayacağı Listenable'a çeviren yardımcı sınıf
class AuthListenable extends ChangeNotifier {
  final Ref ref;
  AuthListenable(this.ref) {
    ref.listen<AuthStatus>(authStateProvider, (previous, next) {
      notifyListeners();
    });
  }
}
