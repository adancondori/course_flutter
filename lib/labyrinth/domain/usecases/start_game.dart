import 'package:course_flutter/labyrinth/data/repositories/game_repository_impl.dart';

class StartGame {
  final GameRepository repository;

  StartGame(this.repository);

  void call() {
    repository.getPlayer();
    repository.getMonsters();
    repository.getMaze();
  }
}
