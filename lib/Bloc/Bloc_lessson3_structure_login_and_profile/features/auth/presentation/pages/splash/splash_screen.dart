import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import 'splash_animation.dart';
import 'splash_navigator.dart';

// /// First screen the user sees.

// /// Listens to AuthBloc and redirects as soon as auth status is known.
// /// AuthBloc fires AppStarted in main.dart, so this screen typically
// /// resolves in under 200ms (from Hive cache) with no visible flicker.

class InitialSplashScreen extends StatelessWidget {
  const InitialSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => SplashNavigator.handleNavigation(context, state),
        child: const Center(child: SplashAnimation()),
      ),
    );
  }
}




















//OLD VERSION

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/core/routes/app_routes.dart';

// import '../../presentation/bloc/auth_bloc.dart';
// import '../bloc/auth_state.dart';

// // /// First screen the user sees.

// // /// Listens to AuthBloc and redirects as soon as auth status is known.
// // /// AuthBloc fires AppStarted in main.dart, so this screen typically
// // /// resolves in under 200ms (from Hive cache) with no visible flicker.

// class InitialSplashScreen extends StatefulWidget {
//   const InitialSplashScreen({super.key});

//   @override
//   State<InitialSplashScreen> createState() => _InitialSplashScreenState();
// }

// class _InitialSplashScreenState extends State<InitialSplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;
//   late Animation<double> _fade;

//   @override
//   void initState() {
//     super.initState();

//     // --- ANIMATION CONTROLLER ---
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1400),
//     );

//     // --- SCALE ANIMATION (grow + slight bounce) ---
//     _scale = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween(
//           begin: 0.3,
//           end: 1.1,
//         ).chain(CurveTween(curve: Curves.easeOutBack)),
//         weight: 70,
//       ),
//       TweenSequenceItem(
//         tween: Tween(
//           begin: 1.1,
//           end: 1.0,
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 30,
//       ),
//     ]).animate(_controller);

//     // --- FADE ANIMATION (fade in) ---
//     _fade = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).chain(CurveTween(curve: Curves.easeIn)).animate(_controller);

//     // Start animation immediately
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handleNavigation(BuildContext context, AuthState state) async {
//     Future.microtask(() async {
//       await Future.delayed(const Duration(seconds: 2));

//       if (!context.mounted) return;
//       switch (state) {
//         case AuthAuthenticated _:
//           context.go(AppRoutes.home);
//           break;

//         case AuthUnauthenticated _:
//           context.go(AppRoutes.login);
//           break;

//         case AuthError _:
//           context.go(AppRoutes.login);
//           break;

//         default:
//           // Even on error, redirect to login so user can retry
//           context.go(AppRoutes.login);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: BlocListener<AuthBloc, AuthState>(
//         // No builder needed here — we always show the logo.
//         listener: (context, state) => _handleNavigation(context, state),
//         child: Center(
//           child: FadeTransition(
//             opacity: _fade,
//             child: ScaleTransition(
//               scale: _scale,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   FlutterLogo(size: 90),
//                   SizedBox(height: 24),
//                   Text(
//                     "Recipe App",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
