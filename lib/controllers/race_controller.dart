import 'dart:async';
import 'dart:math';
import 'package:course_flutter/models/car.dart';

class RaceController {
  final List<Car> cars;
  final StreamController<List<Car>> _raceController =
      StreamController<List<Car>>.broadcast();
  final Random _random = Random();
  bool _raceFinished = false;
  Timer? _raceTimer;
  Timer? _weatherTimer;

  RaceController({required this.cars});

  Stream<List<Car>> get raceStream => _raceController.stream;

  double _width = 0.0;

  void startRace(double width, {int interval = 200}) {
    _width = width;
    _raceFinished = false;
    _resetCarPositions();

    _raceTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
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
        _raceFinished = true;
        _sendBroadcast(car.name);
        break;
      }
    }
  }

  void simulateWeatherConditions() {
    _weatherTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_raceFinished) {
        timer.cancel();
      } else {
        int weatherEffect = _random.nextInt(20) - 10; // Simula viento, etc.
        for (var car in cars) {
          car.position += weatherEffect; // Ajusta la velocidad por el clima
        }
        _raceController.sink.add(List<Car>.from(cars));
      }
    });
  }

  Future<int> calculateReward(Car car) async {
    return await Future.delayed(Duration(seconds: 1), () {
      int reward = (car.position / _width * 100).toInt();
      return reward;
    });
  }

  void awardRewards() async {
    for (var car in cars) {
      int reward = await calculateReward(car);
      print("Car ${car.name} has earned $reward points!");
    }
  }

  void _sendBroadcast(String carName) {
    print("Broadcast: Car $carName has won the race!");
    // En un entorno real, aquí enviarías el broadcast con un Intent
  }

  void dispose() {
    _raceTimer?.cancel();
    _weatherTimer?.cancel();
    _raceController.close();
  }
}
