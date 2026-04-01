import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Cubit_lesson2/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login() async {
    emit(LoginLoading());

    await Future.delayed(Duration(seconds: 2)); // fake API call

    emit(LoginSuccess());
  }
}