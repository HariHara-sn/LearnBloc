import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/core/routes/app_router.dart';
import 'package:learn_bloc/Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/presentation/bloc/auth_event.dart';

import 'Bloc/Bloc_lessson3_structure_login_and_profile/core/services/bloc_observer.dart';
import 'Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/data/repositories/auth_repository_impl.dart';
import 'Bloc/Bloc_lessson3_structure_login_and_profile/features/auth/presentation/bloc/auth_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialise Firebase
  await Firebase.initializeApp();

  // Initialise Hive
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  await Hive.openBox('profileBox');

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // BLoC observer — only active in debug builds
  assert(() {
    Bloc.observer = AppBlocObserver();
    return true;
  }());

  // ── Wire up the dependency graph ──────────────────────────────
  //
  //  DataSource  →  RepositoryImpl  →  BLoC
  //
  // BLoCs only ever see the abstract Repository interface.
  // Swapping Firebase for another provider = change only the DataSource.

  final authDataSource = FirebaseAuthDataSource();
  final authRepository = AuthRepositoryImpl(authDataSource);

  // final profileDataSource = ProfileLocalDataSource();
  // final profileRepository = ProfileRepositoryImpl(profileDataSource);

  runApp(
    RecipeApp(
      authRepository: authRepository,
      // profileRepository: profileRepository,
    ),
  );
}

class RecipeApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  // final ProfileRepositoryImpl profileRepository;

  const RecipeApp({
    super.key,
    required this.authRepository,
    // required this.profileRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // AuthBloc fires AppStarted immediately via cascade (..)
        BlocProvider(
          create: (_) => AuthBloc(authRepository)..add(AppStarted()),
        ),
        // UserBloc starts idle; loads after auth is confirmed
        // BlocProvider(
        //   create: (_) => UserBloc(profileRepository),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Recipe App',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}