import 'package:course_flutter/page_counter/bloc/counter_bloc.dart';
import 'package:course_flutter/page_counter/bloc/counter_event.dart';
import 'package:course_flutter/page_counter/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${state.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${state.name}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () => counterBloc.add(CounterDecrement()),
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: () => counterBloc.add(CounterReset()),
          tooltip: 'Reset',
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: "btn3",
          onPressed: () => counterBloc.add(CounterIncrement()),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 16),
      ]),
    );
  }
}
