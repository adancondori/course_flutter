import 'package:course_flutter/presentacion/cadenas/cadena_page.dart';
import 'package:course_flutter/presentacion/menu/home_page.dart';
import 'package:course_flutter/presentacion/numeros/numero_page.dart';
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
            path: 'numerosx',
            builder: (context, state) => NumeroPage(),
          ),
          GoRoute(
            path: 'cadenasx',
            builder: (context, state) => CadenaPage(),
          ),
        ],
      ),
    ],
  );
}
