import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/splash/splash_screen.dart';
import 'app_routes.dart';
import '../../features/auth/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../error/error_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.initial,
    routes: [

      GoRoute(
        path: AppRoutes.initial,
        builder: (context, state) => const InitialSplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),


      // GoRoute(
      //   path: AppRoutes.bottomNav,
      //   name: AppRoutes.bottomNav,
      //   builder: (context, state) => const MyNavigationBar(),
      // ),
    ],

    errorBuilder: (context, state) => ErrorScreen(state : state),
  );
}