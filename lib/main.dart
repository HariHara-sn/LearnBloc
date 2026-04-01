import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/auth/Presentation/splash_screen.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/google_sign_in_bloc.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/presentation/home_screen.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/presentation/login_screen.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/repository/login_repository.dart';

import 'Bloc/Bloc_lesson2_google_signIn/auth/bloc/auth_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('authBox');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GoogleSignInRepository(),
      child: MultiBlocProvider(
        providers: [
          // Google Login BLoC
          BlocProvider(
            create: (context) => GoogleSignInBloc(
              repository: context.read<GoogleSignInRepository>(),
            ),
          ),

          // Auth Bloc (checks Hive token)
          BlocProvider(
            create: (context) =>
                AuthBloc(context.read<GoogleSignInRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Google Sign In Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4285F4),
            ),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
