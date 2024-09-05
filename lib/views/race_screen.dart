import 'package:course_flutter/controllers/race_controller.dart';
import 'package:course_flutter/models/car.dart';
import 'package:flutter/material.dart';

class RaceScreen extends StatefulWidget {
  const RaceScreen({super.key});

  @override
  _RaceScreenState createState() => _RaceScreenState();
}

class _RaceScreenState extends State<RaceScreen> {
  late RaceController _raceController;
  final List<Car> _cars = [
    Car(id: 1, name: 'pegazo'),
    Car(id: 2, name: 'rayo'),
    Car(id: 3, name: 'torci'),
  ];

  @override
  void initState() {
    super.initState();
    _raceController = RaceController(cars: _cars);
  }

  @override
  void dispose() {
    _raceController.dispose();
    super.dispose();
  }

  void _startRace({int interval = 200}) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    _raceController.startRace(width, interval: interval);
  }

  void _startRaceWithWeather() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    _raceController.startRace(width);
    _raceController.simulateWeatherConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Race'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _startRace(interval: 100),
                child: Text("Quick Race"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _startRaceWithWeather,
                child: Text("Race with Weather"),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<Car>>(
              stream: _raceController.raceStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Press Start to begin the race!'),
                  );
                }

                final cars = snapshot.data!;
                return Column(
                  children: cars.map((car) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                          Positioned(
                            left: car.position.toDouble(),
                            child: Image.asset(
                              'assets/images/${car.name.toLowerCase()}.png', // que los nombres de imagen son car1.png, car2.png
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
