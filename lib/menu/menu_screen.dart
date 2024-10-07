import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/screenA'); // Navega a la Pantalla A
              },
              child: Text('Ir a Pantalla A'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/screenB'); // Navega a la Pantalla B
              },
              child: Text('Ir a Pantalla B'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/screenC'); // Navega a la Pantalla C
              },
              child: Text('JUEGO'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/screenD'); // Navega a la Pantalla C
              },
              child: Text('JUEGO2'),
            ),
          ],
        ),
      ),
    );
  }
}
