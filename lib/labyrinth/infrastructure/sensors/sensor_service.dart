import 'package:course_flutter/labyrinth/core/entities/player.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  void listenToSensors(Player player, Function onPlayerMoved) {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      double dx = event.x / 10;
      double dy = event.y / 10;

      player.move(dx, dy);
      print(dx);
      print(dy);
      // Llamamos a la función callback para actualizar la UI
      onPlayerMoved();
    });
  }
}
