import 'package:course_flutter/labyrinth/core/entities/maze.dart';
import 'package:course_flutter/labyrinth/core/entities/monster.dart';
import 'package:course_flutter/labyrinth/core/entities/player.dart';

abstract class GameRepository {
  Player getPlayer();
  List<Monster> getMonsters();
  Maze getMaze();
}
