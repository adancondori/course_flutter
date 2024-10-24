// main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/application/use_cases/user_use_cases.dart';
import 'package:course_flutter/infrastructure/repositories_impl/firebase_user_repository.dart';
import 'package:course_flutter/presentation/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final userRepository = FirebaseUserRepository(FirebaseFirestore.instance);

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final FirebaseUserRepository userRepository;

  const MyApp({required this.userRepository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        getUsers: GetUsers(userRepository),
        deleteUser: DeleteUser(userRepository),
        updateUser: UpdateUser(userRepository),
        addUser: AddUser(userRepository),
      ),
    );
  }
}
