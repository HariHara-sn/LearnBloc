import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson2_google_signIn/repository/login_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInRepository loginRepository;

  AuthBloc(this.loginRepository) : super(AuthInitialState()) {
    on<CheckAuthEvent>((event, emit) {
      final loggedIn = loginRepository.isLoggedIn();
      if (loggedIn) {
        emit(AuthLoggedInState());
      } else {
        emit(AuthLoggedOutState());
      }
    });
  }
}