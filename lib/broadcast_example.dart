import 'dart:async';

import 'package:flutter/material.dart';

class BroadcastExample extends StatefulWidget {
  @override
  _BroadcastExampleState createState() => _BroadcastExampleState();
}

class _BroadcastExampleState extends State<BroadcastExample> {
  final StreamController<String> _broadcastController =
      StreamController<String>.broadcast();

  @override
  void dispose() {
    _broadcastController.close();
    super.dispose();
  }

  void _sendBroadcast() {
    _broadcastController.sink
        .add("Mensaje de broadcast enviado a ${DateTime.now()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Broadcast Example"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _sendBroadcast,
            child: Text("Enviar Broadcast"),
          ),
          StreamBuilder<String>(
            stream: _broadcastController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  title: Text(snapshot.data!),
                );
              } else {
                return ListTile(
                  title: Text("Esperando broadcast..."),
                );
              }
            },
          ),
          StreamBuilder<String>(
            stream: _broadcastController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  title: Text("Listener 2: ${snapshot.data!}"),
                );
              } else {
                return ListTile(
                  title: Text("Listener 2 esperando broadcast..."),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
