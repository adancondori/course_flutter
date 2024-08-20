import 'package:course_flutter/cadenas.dart';
import 'package:course_flutter/home_page.dart';
import 'package:course_flutter/numeros.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }

  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: 'numeros',
            builder: (context, state) => Numeros(),
          ),
          GoRoute(
            path: 'cadenas',
            builder: (context, state) => Cadenas(),
          ),
        ],
      ),
    ],
  );
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //       useMaterial3: true,
  //     ),
  //     home: const MyHomePage(title: 'Flutter Demo Home Page'),
  //   );
  // }
}
