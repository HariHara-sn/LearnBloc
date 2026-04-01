// Use this main file only for this folder. if you want to use. cut and paste from outside folder and run

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Cubit_lesson3/login_cubit.dart';
import 'package:learn_bloc/Cubit_lesson3/login_state.dart';

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

class LoginPageCubit extends StatefulWidget {
  const LoginPageCubit({super.key});

  @override
  State<LoginPageCubit> createState() => _LoginPageCubitState();
}

class _LoginPageCubitState extends State<LoginPageCubit> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: Text(
          'Login Page with cubit with blocConsumer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          TextField(
            controller: passwordController,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
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
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage,
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
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.red,
                  ),
                );
              }

              return ElevatedButton(
                onPressed: () {

                  context.read<LoginCubit>().login(emailController.text, passwordController.text);
                  // context.read<LoginCubit>().login("Hari", "1234");
                },
                child: Text("Login"),
              );
            },
          ),
        ],
      ),
    );
  }
}
