// Use this main file only for this folder. if you want to use. cut and paste from outside folder and run
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Cubit_lesson1/counter_cubit.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: CounterPage(),
      ),
    ),
  );
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubitState = context.read<CounterCubit>();
    // final counterCubitStateValue = context.watch<CounterCubit>().state;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: const Text(
          "Learn Bloc with Cubit",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(
              "$state",
              // '$counterCubitStateValue',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        children: [
          const Spacer(),
          FloatingActionButton(
            onPressed: () => counterCubitState.increment(),
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.green),
          ),
          FloatingActionButton(
            onPressed: () => counterCubitState.decrement(),
            backgroundColor: Colors.white,
            child: const Icon(Icons.remove, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
