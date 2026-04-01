# ✅ What is a Cubit?

A **Cubit** is a lightweight state manager.
You give it an initial state → it emits new states → UI rebuilds when state changes.

Think of it like this:

**Cubit = a class that holds data + methods that update that data.**

---

# ✅ Example 1: A Simple Counter Cubit

(And I’ll explain every line)

### `counter_cubit.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
```

---

# 🔍 Line-by-Line Explanation

### `import 'package:flutter_bloc/flutter_bloc.dart';`

Brings in the Cubit and Bloc tools from the Flutter Bloc package so you can use `Cubit`, `emit`, and more.

---

### `class CounterCubit extends Cubit<int> {`

You create a new class called **CounterCubit**.
It **extends** `Cubit<int>` → meaning the state it manages is an **integer**.

---

### `CounterCubit() : super(0);`

This is the **constructor**.

* `super(0)` sets the **initial state** to `0`.
* So when the Cubit starts, the counter value = 0.

---

### `void increment() => emit(state + 1);`

Defines the **increment** function.

* `state` gives the current value.
* `emit(state + 1)` sends a NEW state with the value increased by 1.
* The UI will rebuild because a new state has been emitted.

---

### `void decrement() => emit(state - 1);`

Same as increment but subtracts one.

---

# 🧱 Now, let’s use the Cubit in a Flutter widget

### `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}
```

---

# 🔍 Why do we use BlocProvider?
- Cubit/Bloc objects must be accessible to the UI.
- Provider gives access to:
    - BlocBuilder
    - BlocListener
    - BlocConsumer

- BlocProvider = supplier
- Cubit = data + logic
- UI = consumer
### `BlocProvider(`

Wraps your widget tree and **provides** the CounterCubit to all widgets below it.

---

### `create: (_) => CounterCubit(),`

Tells Flutter how to build the Cubit object when needed.

---

### `child: MaterialApp(...)`

Your app runs with the Cubit available to the whole widget tree.

---

# 📄 Counter Page UI

```dart
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) {
            return Text(
              '$count',
              style: TextStyle(fontSize: 40),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
```

---

# 🔍 Explanation

### `BlocBuilder<CounterCubit, int>(...)`

This widget listens to the Cubit’s state changes.

* Whenever `emit()` is called → builder runs → UI updates.

---

### `builder: (context, count)`

* `count` is the integer state from the Cubit.

---

### `Text('$count')`

Displays the current number.

---

### Floating buttons

* `context.read<CounterCubit>().increment()`
  Calls increment function inside Cubit.

* `context.read<CounterCubit>().decrement()`
  Calls decrement function.

# context.read vs context.watch
- final counterCubitState = context.read<CounterCubit>();
- final counterCubitStateValue = context.watch<CounterCubit>().state;

1. If you want to update the state use the context.read
2. If you want to listen and display the state use the context.watch

# we have context.watch<CounterCubit>().state then why do we need BlocBuilder ?
-  context.watch<CounterCubit>().state = This rebuilds the entire widget which is more costly and expensive.
- BlocBuilder = only rebuilds the part of the widget tree that needs to change when the state changes, making it more efficient.