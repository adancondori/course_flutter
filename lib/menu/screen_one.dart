import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen One'),
      ),
      body: const Center(
        child: Text(
          'This is Screen One',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
