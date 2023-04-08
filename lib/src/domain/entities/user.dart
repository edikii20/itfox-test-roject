import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;

  const User({
    required this.email,
    required this.password,
  });

  User copyWith({
    String? email,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'User(email: $email, password: $password)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
