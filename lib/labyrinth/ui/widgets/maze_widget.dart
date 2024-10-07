import 'package:course_flutter/labyrinth/core/entities/monster.dart';
import 'package:course_flutter/labyrinth/core/entities/player.dart';
import 'package:flutter/material.dart';

class MazeWidget extends StatelessWidget {
  final Player player;

  MazeWidget({required this.player});

  @override
  Widget build(BuildContext context) {
    final monsters = [Monster(2.0, 2.0), Monster(4.0, 4.0)];
    final maze = [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 1, 0, 1],
      [1, 0, 1, 0, 1],
      [1, 1, 1, 1, 1],
    ];

    return Stack(
      children: [
        // Dibuja el laberinto
        GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemCount: maze.length * maze[0].length,
          itemBuilder: (context, index) {
            int x = index ~/ 5;
            int y = index % 5;
            return Container(
              decoration: BoxDecoration(
                color: maze[x][y] == 1 ? Colors.black : Colors.white,
                border: Border.all(color: Colors.grey),
              ),
            );
          },
        ),
        // Dibuja al jugador
        Positioned(
          top: player.y * 50,
          left: player.x * 50,
          child: Icon(Icons.circle, color: Colors.blue, size: 30),
        ),
        // Dibuja los monstruos
        ...monsters.map((monster) {
          return Positioned(
            top: monster.y * 50,
            left: monster.x * 50,
            child: Icon(Icons.circle, color: Colors.red, size: 30),
          );
        }).toList(),
      ],
    );
  }
}
