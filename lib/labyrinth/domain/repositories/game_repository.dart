import 'package:course_flutter/labyrinth/core/entities/maze.dart';
import 'package:course_flutter/labyrinth/core/entities/monster.dart';
import 'package:course_flutter/labyrinth/core/entities/player.dart';
import 'package:course_flutter/labyrinth/data/repositories/game_repository_impl.dart';

class GameRepositoryImpl implements GameRepository {
  @override
  Player getPlayer() => Player(0.0, 0.0);

  @override
  List<Monster> getMonsters() {
    return [Monster(2.0, 2.0), Monster(4.0, 4.0)];
  }

  @override
  Maze getMaze() {
    return Maze([
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 1, 0, 1],
      [1, 0, 1, 0, 1],
      [1, 1, 1, 1, 1],
    ]);
  }
}
