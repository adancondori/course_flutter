import 'dart:async';
import 'dart:math';
import 'horse.dart';

class RaceController {
  final List<Horse> horses;
  final StreamController<List<Horse>> _raceController =
      StreamController<List<Horse>>.broadcast();
  final Random _random = Random();
  Timer? _raceTimer;
  Timer? _weatherTimer;
  double _width = 0.0;
  static const _espaceImage = 230;

  RaceController({required this.horses});

  Stream<List<Horse>> get raceStream => _raceController.stream;

  void startRace(double width, {int interval = 200}) {
    _width = width;
    _resetHorsePositions();

    _raceTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      _updateHorsePositions();
      _raceController.sink.add(List<Horse>.from(horses));
      if (_allHorsesFinished()) {
        timer.cancel();
      }
    });
  }

  void _resetHorsePositions() {
    for (var horse in horses) {
      horse.position = 0;
      horse.finished = false;
    }
  }

  void _updateHorsePositions() {
    for (var horse in horses) {
      if (!horse.finished) {
        horse.position += _random.nextInt(40);
        if (horse.position >= _width - _espaceImage) {
          horse.position = (_width - _espaceImage).toInt();
          horse.finished = true;
        }
      }
    }
  }

  bool _allHorsesFinished() {
    return horses.every((horse) => horse.finished);
  }

  void simulateWeatherConditions() {
    _weatherTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_allHorsesFinished()) {
        timer.cancel();
      } else {
        int weatherEffect = _random.nextInt(20) - 10;
        for (var horse in horses) {
          if (!horse.finished) {
            horse.position += weatherEffect;
          }
        }
        _raceController.sink.add(List<Horse>.from(horses));
      }
    });
  }

  void dispose() {
    _raceTimer?.cancel();
    _weatherTimer?.cancel();
    _raceController.close();
  }
}
