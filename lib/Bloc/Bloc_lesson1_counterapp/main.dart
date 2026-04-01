// Use this main file only for this folder. if you want to use. cut and paste from outside folder and run
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/Bloc/Bloc_lesson1_counterapp/counter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: BlocCounterPage(),
      ),
    ),
  );
}

class BlocCounterPage extends StatelessWidget {
  const BlocCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBlocState = context.read<CounterBloc>();
    // final counterCubitStateValue = context.watch<CounterCubit>().state;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: const Text("Learn Bloc", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              // '${state.count}',
              // '$state',
              state.count.toString(),
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
            onPressed: () => counterBlocState.add(IncrementButtonPressed()),
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.green),
          ),
          FloatingActionButton(
            heroTag: "dec",
            tooltip: "Hari dec",
            onPressed: () => counterBlocState.add(DecrementButtonPressed()),
            backgroundColor: Colors.white,
            child: const Icon(Icons.remove, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
