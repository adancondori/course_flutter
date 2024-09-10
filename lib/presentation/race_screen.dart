import 'package:flutter/material.dart';
import '../application/race_presenter.dart';
import '../domain/horse.dart';

class RaceScreen extends StatefulWidget {
  const RaceScreen({super.key});

  @override
  _RaceScreenState createState() => _RaceScreenState();
}

class _RaceScreenState extends State<RaceScreen> {
  late RacePresenter _racePresenter;
  final List<Horse> _horses = [];
  List<Horse> _topHorses = [];

  @override
  void initState() {
    super.initState();
    _racePresenter = RacePresenter();
  }

  @override
  void dispose() {
    _racePresenter.dispose();
    super.dispose();
  }

  void _startRace({int interval = 200}) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    _racePresenter.startRace(width, interval, (progress) {
      setState(() {
        _horses.clear();
        _horses.addAll(progress);
      });
    }, (ranking) {
      setState(() {
        // Actualizar el ranking cuando los dos primeros caballos lleguen
        _topHorses = ranking;
      });
    });
  }

  void _startRaceWithWeather() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    _racePresenter.startRaceWithWeather(width, (progress) {
      setState(() {
        _horses.clear();
        _horses.addAll(progress);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final finishLinePosition = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horse Race'),
        backgroundColor: Colors.brown[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green[200],
          // Alternativamente, puedes usar una imagen de fondo
          // image: DecorationImage(
          //   image: AssetImage('assets/images/race_background.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          children: [
            // Mostrar el ranking de los dos primeros caballos
            if (_topHorses.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      if (_topHorses.length >= 1)
                        Row(
                          children: [
                            Icon(Icons.emoji_events, color: Colors.amber[700]),
                            const SizedBox(width: 8),
                            Text(
                              '1st Place: ${_topHorses[0].name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      if (_topHorses.length >= 2)
                        Row(
                          children: [
                            Icon(Icons.emoji_events, color: Colors.grey[700]),
                            const SizedBox(width: 8),
                            Text(
                              '2nd Place: ${_topHorses[1].name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            // Área de la carrera con los carriles y la línea de meta
            Expanded(
              child: Stack(
                children: [
                  // Lista de carriles de los caballos
                  ListView.builder(
                    itemCount: _horses.length,
                    itemBuilder: (context, index) {
                      final horse = _horses[index];
                      return Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color:
                              index % 2 == 0 ? Colors.white : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.brown, width: 2),
                        ),
                        child: Row(
                          children: [
                            // Nombre del caballo (estático)
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: Text(
                                  horse.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Área donde se mueve el caballo
                            Expanded(
                              child: Stack(
                                children: [
                                  // Puedes añadir más decoraciones aquí si lo deseas
                                  // Imagen del caballo que se mueve
                                  Positioned(
                                    left: horse.position.toDouble(),
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/${horse.nameImg}',
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Línea de meta
                  Positioned(
                    left: finishLinePosition,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 4,
                      color: Colors.red,
                      child: Column(
                        children: List.generate(_horses.length, (index) {
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              color: Colors.transparent,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Botones para iniciar la carrera
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón "Quick Race"
                  ElevatedButton(
                    onPressed: () => _startRace(interval: 100),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Quick Race"),
                  ),
                  const SizedBox(width: 20),
                  // Botón "Race with Weather"
                  ElevatedButton(
                    onPressed: _startRaceWithWeather,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Race with Weather"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
