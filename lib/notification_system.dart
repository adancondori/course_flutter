import 'dart:async';

import 'package:flutter/material.dart';

class NotificationSystem extends StatefulWidget {
  const NotificationSystem({super.key});

  @override
  _NotificationSystemState createState() => _NotificationSystemState();
}

class _NotificationSystemState extends State<NotificationSystem> {
  final StreamController<String> _notificationController =
      StreamController<String>.broadcast();
  StreamSubscription<String>? _subscription1;
  StreamSubscription<String>? _subscription2;
  bool _isSubscribed1 = false;
  bool _isSubscribed2 = false;

  @override
  void dispose() {
    _notificationController.close();
    _subscription1?.cancel();
    _subscription2?.cancel();
    super.dispose();
  }

  void _startBroadcast() {
    _notificationController.sink
        .add("Notificación emitida a las ${DateTime.now()}");
  }

  void _subscribeListener1() {
    if (!_isSubscribed1) {
      _subscription1 = _notificationController.stream.listen((data) {
        setState(() {
          _isSubscribed1 = true;
        });
      });
    }
  }

  void _unsubscribeListener1() {
    _subscription1?.cancel();
    setState(() {
      _isSubscribed1 = false;
    });
  }

  void _subscribeListener2() {
    if (!_isSubscribed2) {
      _subscription2 = _notificationController.stream.listen((data) {
        setState(() {
          _isSubscribed2 = true;
        });
      });
    }
  }

  void _unsubscribeListener2() {
    _subscription2?.cancel();
    setState(() {
      _isSubscribed2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast with StreamController'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _startBroadcast,
            child: Text("Emitir Notificación"),
          ),
          ListTile(
            title: Text("Listener 1"),
            subtitle: _isSubscribed1
                ? StreamBuilder<String>(
                    stream: _notificationController.stream,
                    builder: (context, snapshot) {
                      return Text(snapshot.hasData
                          ? snapshot.data!
                          : "Esperando notificación...");
                    },
                  )
                : Text("No suscrito"),
            trailing: _isSubscribed1
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: _unsubscribeListener1,
                  )
                : IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: _subscribeListener1,
                  ),
          ),
          ListTile(
            title: Text("Listener 2"),
            subtitle: _isSubscribed2
                ? StreamBuilder<String>(
                    stream: _notificationController.stream,
                    builder: (context, snapshot) {
                      return Text(snapshot.hasData
                          ? snapshot.data!
                          : "Esperando notificación...");
                    },
                  )
                : Text("No suscrito"),
            trailing: _isSubscribed2
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: _unsubscribeListener2,
                  )
                : IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: _subscribeListener2,
                  ),
          ),
        ],
      ),
    );
  }
}
