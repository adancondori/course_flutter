import 'package:course_flutter/labyrinth/ui/screens/home_screen.dart';
import 'package:course_flutter/menu/menu_screen.dart';
import 'package:course_flutter/pages/homepage.dart';
import 'package:course_flutter/sensor/sensor.dart';
import 'package:course_flutter/snake/ui/snake_game_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // Definir las rutas para las diferentes pantallas
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MenuScreen(),
      ),
      GoRoute(
        path: '/screenA',
        builder: (context, state) => MyHomePage(),
      ),
      GoRoute(
        path: '/screenB',
        builder: (context, state) => Sensor(),
      ),
      GoRoute(
        path: '/screenC',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/screenD',
        builder: (context, state) => SnakeGamePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Navigation Example',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
    );
  }
}
