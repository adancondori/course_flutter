import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/numerosx');
              },
              child: Text('Go Numeros'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/cadenasx');
              },
              child: Text('Go Cadenas'),
            ),
          ],
        ),
      ),
    );
  }
}
