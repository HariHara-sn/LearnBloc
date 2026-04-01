part of 'counter_bloc.dart';

sealed class CounterEvent {}

class IncrementButtonPressed extends CounterEvent{}
class DecrementButtonPressed extends CounterEvent{}