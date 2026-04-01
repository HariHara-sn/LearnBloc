import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Cubit_lesson3/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    if (email == "Hari" && password == "1234") {
      await Future.delayed(Duration(seconds: 2)); // fake API call
      emit(LoginSuccess());
    } else {
      await Future.delayed(Duration(seconds: 2)); // fake API call
      emit(LoginFailure("Invalid credentials"));
    }
  }
}
