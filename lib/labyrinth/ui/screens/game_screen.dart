import 'package:course_flutter/labyrinth/domain/repositories/game_repository.dart';
import 'package:flutter/material.dart';
import '../../infrastructure/sensors/sensor_service.dart';
import '../../core/entities/player.dart';
import '../widgets/maze_widget.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Player player;
  late SensorService sensorService;

  @override
  void initState() {
    super.initState();
    final repository = GameRepositoryImpl();
    player = repository.getPlayer();
    sensorService = SensorService();

    // Escuchar cambios en los sensores y actualizar la posición del jugador
    sensorService.listenToSensors(player, onPlayerMoved);
  }

  // Función para actualizar el estado cuando el jugador se mueve
  void onPlayerMoved() {
    setState(() {
      // Esto forzará la actualización del UI para mostrar el nuevo movimiento del jugador
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MazeWidget(player: player),
    );
  }
}
