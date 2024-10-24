// infrastructure/repositories_impl/firebase_user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/domain/entities/user.dart';
import 'package:course_flutter/domain/repositories/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore firestore;

  FirebaseUserRepository(this.firestore);

  @override
  Future<void> addUser(User user) async {
    print(user);
    await FirebaseFirestore.instance.collection('User').doc(user.id).set({
      'Name': user.name,
      'Profession': user.profession,
      'Age': user.age,
    });
  }

  @override
  Future<void> updateUser(User user) async {
    print(user);
    await FirebaseFirestore.instance.collection('User').doc(user.id).update({
      'Name': user.name,
      'Profession': user.profession,
      'Age': user.age,
    });
  }

  @override
  Future<void> deleteUser(String id) async {
    await FirebaseFirestore.instance.collection('User').doc(id).delete();
  }

  @override
  Stream<List<User>> getUsers() {
    return FirebaseFirestore.instance
        .collection('User')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return User(
          id: doc.id,
          name: doc['Name'],
          profession: doc['Profession'],
          age: doc['Age'],
        );
      }).toList();
    });
  }
}
