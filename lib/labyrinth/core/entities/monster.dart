import 'package:course_flutter/labyrinth/core/entities/player.dart';

class Monster {
  double x;
  double y;

  Monster(this.x, this.y);

  bool checkCollision(Player player) {
    return (x - player.x).abs() < 0.1 && (y - player.y).abs() < 0.1;
  }
}
