import 'package:course_flutter/models/numero.dart';
import 'package:flutter/material.dart';

class NumeroPage extends StatefulWidget {
  const NumeroPage({super.key});

  @override
  _NumeroPageState createState() => _NumeroPageState();
}

class _NumeroPageState extends State<NumeroPage> {
  String? _selectedExercise;
  int _inputNumber = 0;
  String _result = '';
  Numero numero = Numero();

  final List<String> _exercises = [
    'Listar los N primeros números pares',
    'Listar los N primeros números impares',
    'Calcular la suma de los N primeros números naturales',
  ];

  void _executeExercise() {
    switch (_selectedExercise) {
      case 'Listar los N primeros números pares':
        _result = numero.listEvenNumbers(_inputNumber);
        break;
      case 'Listar los N primeros números impares':
        _result = numero.listOddNumbers(_inputNumber);
        break;
      case 'Calcular la suma de los N primeros números naturales':
        _result = numero.sumNaturalNumbers(_inputNumber).toString();
        break;
      default:
        _result = 'Selecciona un ejercicio y un número válido.';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CodeQuest - NumeroPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: Text('Selecciona un ejercicio'),
              value: _selectedExercise,
              items: _exercises.map((String exercise) {
                return DropdownMenuItem<String>(
                  value: exercise,
                  child: Text(exercise),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedExercise = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa un número',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _inputNumber = int.tryParse(value) ?? 0;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _executeExercise,
              child: Text('Ejecutar Ejercicio'),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
