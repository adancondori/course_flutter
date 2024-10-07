import 'dart:async';

import 'package:course_flutter/snake/core/entities/snake.dart';
import 'package:course_flutter/snake/domain/game_logic/direction.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  StreamSubscription? _accelerometerSubscription;

  void listenToSensor(Snake snake, Function(Direction) onDirectionChange) {
    // Cambia a usar accelerometerEvents para suscribirse al stream del sensor
    _accelerometerSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      // Ajustamos el umbral de sensibilidad para un mejor control del movimiento
      if (event.x.abs() > event.y.abs()) {
        if (event.x < -2 && snake.headDirection != Direction.right) {
          onDirectionChange(Direction.left);
        } else if (event.x > 2 && snake.headDirection != Direction.left) {
          onDirectionChange(Direction.right);
        }
      } else {
        if (event.y < -2 && snake.headDirection != Direction.down) {
          onDirectionChange(Direction.up);
        } else if (event.y > 2 && snake.headDirection != Direction.up) {
          onDirectionChange(Direction.down);
        }
      }
    });
  }

  void stop() {
    _accelerometerSubscription?.cancel();
  }
}
