// domain/entities/user.dart
class User {
  final String id;
  final String name;
  final String profession;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.profession,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Profession': profession,
      'Age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map, String documentId) {
    return User(
      id: documentId,
      name: map['Name'] ?? '',
      profession: map['Profession'] ?? '',
      age: map['Age'] ?? 0,
    );
  }
}
