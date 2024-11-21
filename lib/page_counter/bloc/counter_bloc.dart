import 'package:course_flutter/page_counter/bloc/counter_event.dart';
import 'package:course_flutter/page_counter/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0, 'Initial')) {
    on<CounterIncrement>(
        (event, emit) => emit(CounterState(state.counter + 1, 'Incremented')));
    on<CounterDecrement>(
        (event, emit) => emit(CounterState(state.counter - 1, 'Decremented')));
    on<CounterReset>((event, emit) => emit(CounterState(0, 'Reset')));
  }
}
