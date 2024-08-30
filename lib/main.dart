import 'package:course_flutter/broadcast_example.dart';
import 'package:course_flutter/home_page.dart';
import 'package:course_flutter/notification_system.dart';
import 'package:course_flutter/views/race_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RaceScreen(),
    );
  }
}
