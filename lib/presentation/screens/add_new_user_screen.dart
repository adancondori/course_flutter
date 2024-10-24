// presentation/screens/add_new_user_screen.dart
import 'package:course_flutter/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AddNewUserScreen extends StatefulWidget {
  final User? user;
  final Function(User) addUser;

  const AddNewUserScreen({
    this.user,
    required this.addUser,
    Key? key,
  }) : super(key: key);

  @override
  _AddNewUserScreenState createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameController.text = widget.user!.name;
      professionController.text = widget.user!.profession;
      ageController.text = widget.user!.age.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              widget.user != null ? Text('Edit User') : Text('Add New User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: professionController,
              decoration: const InputDecoration(labelText: 'Profession'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final user = User(
                  id: widget.user?.id ?? randomAlphaNumeric(8),
                  name: nameController.text,
                  profession: professionController.text,
                  age: int.parse(ageController.text),
                );
                widget.addUser(user);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
