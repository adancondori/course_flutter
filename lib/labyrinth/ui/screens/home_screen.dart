import 'package:course_flutter/labyrinth/ui/screens/game_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laberinto')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => GameScreen()));
          },
          child: Text('Iniciar Juego'),
        ),
      ),
    );
  }
}
