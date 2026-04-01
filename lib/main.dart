import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/google_sign_in_bloc.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/presentation/login_screen.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/repository/login_repository.dart';

// import 'firebase_options.dart'; // Uncomment after running flutterfire configure

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // Uncomment after flutterfire configure
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GoogleSignInRepository(),
      child: BlocProvider(
        create: (context) => GoogleSignInBloc(
          repository: context.read<GoogleSignInRepository>(),
        ),
        child: MaterialApp(
          title: 'Google Sign In Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4285F4)),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            // '/home': (context) => const HomeScreen(), // Add your home screen here
          },
        ),
      ),
    );
  }
}