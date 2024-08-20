import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CadenaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/');
          },
          child: Text('Back to Home'),
        ),
      ),
    );
  }
}
