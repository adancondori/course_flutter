// application/use_cases/user_use_cases.dart
import 'package:course_flutter/domain/entities/user.dart';
import 'package:course_flutter/domain/repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;

  AddUser(this.repository);

  Future<void> call(User user) {
    return repository.addUser(user);
  }
}

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(User user) {
    return repository.updateUser(user);
  }
}

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> call(String id) {
    return repository.deleteUser(id);
  }
}

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Stream<List<User>> call() {
    return repository.getUsers();
  }
}
