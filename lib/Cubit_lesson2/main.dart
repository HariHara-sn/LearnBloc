// Use this main file only for this folder. if you want to use. cut and paste from outside folder and run

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Cubit_lesson2/login_cubit.dart';
import 'package:learn_bloc/Cubit_lesson2/login_state.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginPageCubit(),
      ),
    ),
  );
}

class LoginPageCubit extends StatelessWidget {
  const LoginPageCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: Text(
          'Login Page with cubit with blocListner',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Logging in...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Login successful!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
        child: Center(
          child: ElevatedButton(
            onPressed: () => context.read<LoginCubit>().login(),
            child: Text('Login'),
          ),
        ),
      ),
    );
  }
}
