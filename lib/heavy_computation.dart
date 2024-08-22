import 'dart:isolate';

import 'package:flutter/material.dart';

class HeavyComputation extends StatefulWidget {
  const HeavyComputation({super.key});

  @override
  _HeavyComputationState createState() {
    return _HeavyComputationState();
  }
}

class _HeavyComputationState extends State<HeavyComputation> {
  String _result = "Presiona el botón para iniciar el cálculo";

  Future<void> _runHeavyComputation() async {
    final response = ReceivePort();
    await Isolate.spawn(_heavyTask, response.sendPort);

    final result = await response.first as String;
    setState(() {
      _result = result;
    });
  }

  static void _heavyTask(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i < 1000000000; i++) {
      sum += i;
    }
    sendPort.send("Cálculo completo: $sum");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_result, textAlign: TextAlign.center),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _runHeavyComputation,
          child: Text("Iniciar Cálculo"),
        ),
      ],
    );
  }
}
