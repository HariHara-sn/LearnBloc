import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../bloc/auth_state.dart';

class SplashNavigator {
  static Future<void> handleNavigation(
    BuildContext context,
    AuthState state,
  ) async {
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));

      if (!context.mounted) return;

      switch (state) {
        case AuthAuthenticated _:
          context.go(AppRoutes.home);
          break;

        case AuthUnauthenticated _:
          context.go(AppRoutes.login);
          break;

        case AuthError _:
          context.go(AppRoutes.login);
          break;

        default:
        // Even on error, redirect to login so user can retry
          context.go(AppRoutes.login);
      }
    });
  }
}



/// OLD VERSION
// listener: (context, state) {
//           Future.microtask(() async {
//             await Future.delayed(const Duration(seconds: 2));
//             if (!context.mounted) {
//               return;
//             }
//             if (state is AuthAuthenticated) {
//               context.go(AppRoutes.home);
//             } else if (state is AuthUnauthenticated) {
//               context.go(AppRoutes.login);
//             } else if (state is AuthError) {
//               // Even on error, redirect to login so user can retry
//               context.go(AppRoutes.login);
//             }
//           });
//         },