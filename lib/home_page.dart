import 'package:course_flutter/page_counter/counter_page.dart';
import 'package:course_flutter/page_post/home_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void goNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePosts()),
    );
  }

  void goNextPokemon() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CounterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bloc Demo APP"),
      ),
      body: draw_screen(context, 0),
    );
  }

  Widget draw_screen(BuildContext context, int counter) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: const Color.fromARGB(255, 11, 32, 223),
            elevation: 0.0,
            height: 50,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Text(
              "Next Screen",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            onPressed: () {
              goNextScreen();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: const Color.fromARGB(255, 11, 32, 223),
            elevation: 0.0,
            height: 50,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Text(
              "Next Screen",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            onPressed: () {
              goNextPokemon();
            },
          )
        ],
      ),
    );
  }
}
