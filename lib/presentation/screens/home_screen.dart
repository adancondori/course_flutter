// presentation/screens/home_screen.dart
import 'package:course_flutter/application/use_cases/user_use_cases.dart';
import 'package:course_flutter/domain/entities/user.dart';
import 'package:course_flutter/presentation/screens/add_new_user_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final GetUsers getUsers;
  final DeleteUser deleteUser;
  final UpdateUser updateUser;
  final AddUser addUser;

  const HomeScreen({
    required this.getUsers,
    required this.deleteUser,
    required this.updateUser,
    required this.addUser,
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<User>> userStream;

  @override
  void initState() {
    super.initState();
    userStream = widget.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: StreamBuilder<List<User>>(
        stream: userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle:
                    Text('Profession: ${user.profession}, Age: ${user.age}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => widget.deleteUser(user.id),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AddNewUserScreen(user: user, addUser: widget.addUser),
                    )),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNewUserScreen(addUser: widget.addUser),
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
