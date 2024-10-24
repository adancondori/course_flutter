import 'package:course_flutter/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
  Stream<List<User>> getUsers();
}
