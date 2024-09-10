import '../domain/race_controller.dart';
import '../domain/horse.dart';

class RacePresenter {
  final List<Horse> horses = [
    Horse(id: 1, name: 'Pegasus', nameImg: '1.png'),
    Horse(id: 2, name: 'Thunder', nameImg: '2.png'),
    Horse(id: 3, name: 'Storm', nameImg: '3.png'),
    Horse(id: 4, name: 'Blaze', nameImg: '4.png'),
    Horse(id: 5, name: 'Pikachu', nameImg: '5.png'),
    Horse(id: 6, name: 'Pepecoin', nameImg: '5.png'),
  ];

  late RaceController _controller;

  List<Horse> topHorses = [];

  RacePresenter() {
    _controller = RaceController(horses: horses);
  }

  void startRace(double width, int interval, Function(List<Horse>) onProgress,
      Function(List<Horse>) onRankingUpdate) {
    topHorses = [];
    _controller.startRace(width, interval: interval);
    _controller.raceStream.listen((progress) {
      _updateTopHorses(onRankingUpdate);
      onProgress(progress);
    });
  }

  void _updateTopHorses(Function(List<Horse>) onRankingUpdate) {
    for (var horse in horses) {
      if (horse.finished && !topHorses.contains(horse)) {
        if (topHorses.length == 1) {
          onRankingUpdate(topHorses);
        } else {
          topHorses.add(horse);
        }
      }
    }
  }

  void startRaceWithWeather(double width, Function(List<Horse>) onProgress) {
    _controller.startRace(width);
    _controller.simulateWeatherConditions();
    _controller.raceStream.listen((progress) {
      onProgress(progress);
    });
  }

  void dispose() {
    _controller.dispose();
  }
}
