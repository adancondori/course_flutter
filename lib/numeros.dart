import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Numeros extends StatefulWidget {
  @override
  _NumerosState createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  String? _selectedExercise;
  int _inputNumber = 0;
  String _result = '';

  final List<String> _exercises = [
    'Listar los N primeros números pares',
    'Listar los N primeros números impares',
    'Calcular la suma de los N primeros números naturales',
  ];

  void _executeExercise() {
    switch (_selectedExercise) {
      case 'Listar los N primeros números pares':
        _result = _listEvenNumbers(_inputNumber);
        break;
      case 'Listar los N primeros números impares':
        _result = _listOddNumbers(_inputNumber);
        break;
      case 'Calcular la suma de los N primeros números naturales':
        _result = _sumNaturalNumbers(_inputNumber).toString();
        break;
      default:
        _result = 'Selecciona un ejercicio y un número válido.';
    }
    setState(() {});
  }

  String _listEvenNumbers(int n) {
    return List.generate(n, (index) => 2 * (index + 1)).join(', ');
  }

  String _listOddNumbers(int n) {
    return List.generate(n, (index) => 2 * index + 1).join(', ');
  }

  int _sumNaturalNumbers(int n) {
    return List.generate(n, (index) => index + 1).reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CodeQuest - Numeros'),
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
