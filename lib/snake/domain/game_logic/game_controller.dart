import 'dart:async';
import 'dart:math';
import 'package:course_flutter/snake/data/sensor_service.dart';
import 'package:course_flutter/snake/domain/game_logic/direction.dart';

import '../../core/entities/snake.dart';
import '../../core/entities/food.dart';
import '../../core/entities/monster.dart';

class GameController {
  final int row, column;
  late Snake snake;
  late Food food;
  List<Monster> monsters = [];
  List<int> borderList = [];
  int score = 0;
  Timer? gameLoopTimer;
  bool isGameOver = false;
  // Instancia del SensorService
  final SensorService _sensorService = SensorService();

  GameController({required this.row, required this.column}) {
    _initGame();
  }

  // Inicializa el juego
  void _initGame() {
    _generateBorders();
    snake = Snake([45, 44, 43], Direction.right); // Serpiente inicial
    food = _generateFood();
    monsters = _generateMonsters();
    score = 0;
    isGameOver = false;
    // Inicia el servicio del sensor para detectar el movimiento del dispositivo
    _sensorService.listenToSensor(snake, (Direction newDirection) {
      // Cambia la dirección de la serpiente según el sensor
      snake.headDirection = newDirection;
    });
  }

  // Inicia el loop del juego
  void startGameLoop(Function() updateUI) {
    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!isGameOver) {
        _updateSnakePosition();
        if (_checkCollision()) {
          isGameOver = true;
          timer.cancel();
          _sensorService.stop();
        }
        updateUI(); // Actualiza la UI después de cada movimiento
      }
    });
  }

  // Detiene el juego (llamado cuando el juego termina)
  void stopGameLoop() {
    gameLoopTimer?.cancel();
    isGameOver = true;
    _sensorService.stop(); // Detener el servicio del sensor
  }

  // Actualiza la posición de la serpiente
  void _updateSnakePosition() {
    // Mueve la serpiente en la dirección actual
    snake.move(snake.headDirection, column);

    if (snake.head == food.position) {
      score++; // Incrementa la puntuación
      food = _generateFood(); // Genera nueva comida
    } else {
      snake.positions.removeLast(); // Si no hay comida, la serpiente no crece
    }
  }

  // Verifica si la serpiente ha colisionado
  bool _checkCollision() {
    return borderList.contains(snake.head) ||
        snake.checkCollisionWithSelf() || // Colisión con su propio cuerpo
        monsters.any((monster) =>
            monster.position == snake.head); // Colisión con un monstruo
  }

  // Genera comida en una posición aleatoria
  Food _generateFood() {
    int foodPosition;
    do {
      foodPosition =
          Random().nextInt(row * column); // Genera una posición aleatoria
    } while (borderList.contains(foodPosition) ||
        snake.positions.contains(foodPosition));
    return Food(foodPosition);
  }

  // Genera una lista de monstruos en posiciones aleatorias
  List<Monster> _generateMonsters() {
    return List.generate(3, (index) {
      int monsterPosition;
      do {
        monsterPosition = Random().nextInt(row * column);
      } while (borderList.contains(monsterPosition) ||
          snake.positions.contains(monsterPosition) ||
          monsterPosition ==
              food.position); // Asegura que el monstruo no esté en la comida o en la serpiente
      return Monster(monsterPosition);
    });
  }

  // Genera las posiciones de las paredes alrededor del borde
  void _generateBorders() {
    for (int i = 0; i < column; i++) {
      borderList.add(i); // Bordes superiores
    }
    for (int i = 0; i < row * column; i += column) {
      borderList.add(i); // Bordes izquierdos
    }
    for (int i = column - 1; i < row * column; i += column) {
      borderList.add(i); // Bordes derechos
    }
    for (int i = (row * column) - column; i < row * column; i++) {
      borderList.add(i); // Bordes inferiores
    }
  }

  // Reinicia el juego cuando el usuario pierde
  void restartGame(Function() updateUI) {
    _initGame(); // Reinicia el estado del juego
    startGameLoop(updateUI); // Inicia nuevamente el loop del juego
  }
}
