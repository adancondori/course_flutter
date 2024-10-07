import 'package:course_flutter/snake/domain/game_logic/game_controller.dart';
import 'package:flutter/material.dart';

class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

class _SnakeGamePageState extends State<SnakeGamePage> {
  late GameController _gameController;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Inicializa el GameController y arranca el bucle del juego
    _gameController = GameController(row: 20, column: 20);
    _gameController.startGameLoop(() {
      setState(() {});
    });
  }

  void _restartGame() {
    setState(() {
      _gameController.stopGameLoop(); // Detiene el juego actual
      _initializeGame(); // Reinicia el juego
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildGameGrid()),
          _buildScore(),
          _buildRestartButton(), // Añadimos el botón de reinicio aquí
        ],
      ),
    );
  }

  Widget _buildGameGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gameController.column,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(1),
          color: _getColorForGridIndex(index),
        );
      },
      itemCount: _gameController.row * _gameController.column,
    );
  }

  Color _getColorForGridIndex(int index) {
    if (_gameController.borderList.contains(index)) {
      return Colors.yellow; // Color para las paredes
    } else if (_gameController.snake.positions.contains(index)) {
      return _gameController.snake.head == index
          ? Colors.green
          : Colors.lightGreen; // Color para la serpiente
    } else if (_gameController.food.position == index) {
      return Colors.red; // Color para la comida
    } else if (_gameController.monsters
        .any((monster) => monster.position == index)) {
      return Colors.purple; // Color para los monstruos
    }
    return Colors.grey.withOpacity(0.05); // Color para los espacios vacíos
  }

  Widget _buildScore() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Score: ${_gameController.score}"),
    );
  }

  Widget _buildRestartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: _restartGame,
        child: const Text('Reiniciar Partida'),
      ),
    );
  }
}
