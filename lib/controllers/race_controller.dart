import 'dart:async';
import 'dart:math';

import 'package:course_flutter/models/car.dart';

class RaceController {
  final List<Car> cars;
  final StreamController<List<Car>> _raceController =
      StreamController<List<Car>>.broadcast();
  final Random _random = Random();
  bool _raceFinished = false;

  RaceController({required this.cars});

  Stream<List<Car>> get raceStream => _raceController.stream;

  double _width = 0.0;

  void startRace(double width) {
    _width = width;
    _raceFinished = false;
    _resetCarPositions();
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (_raceFinished) {
        timer.cancel();
      } else {
        _updateCarPositions();
        _raceController.sink.add(List<Car>.from(cars));
        _checkRaceStatus();
      }
    });
  }

  void _resetCarPositions() {
    for (var car in cars) {
      car.position = 0; // Reinicia la posición de cada auto
    }
  }

  void _updateCarPositions() {
    for (var car in cars) {
      car.position += _random.nextInt(40); // Avanza el auto una posición random
    }
  }

  void _checkRaceStatus() {
    for (var car in cars) {
      if (car.position >= _width - 160) {
        // Suponiendo que 300 es el borde de la pantalla
        _raceFinished = true;
        break;
      }
    }
  }

  void dispose() {
    _raceController.close();
  }
}
