import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../google_sign_in_bloc.dart';
import '../bloc/auth_bloc.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Trigger ONLY ONCEx
    context.read<AuthBloc>().add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          print("Hari Auth Listener → $state");

          if (state is AuthLoggedInState) {
            context.read<GoogleSignInBloc>().add(GoogleSignInRestoreSessionEvent());

            Navigator.pushReplacementNamed(context, "/home");
          } else if (state is AuthLoggedOutState) {
            Navigator.pushReplacementNamed(context, "/login");
          }
        },
        builder: (context, state) {
          print("Auth Builder → $state");

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}