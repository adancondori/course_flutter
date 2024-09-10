import 'package:course_flutter/presentation/race_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HorseRaceApp());
}

class HorseRaceApp extends StatelessWidget {
  const HorseRaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horse Race',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RaceScreen(),
    );
  }
}
