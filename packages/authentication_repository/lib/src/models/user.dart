import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? password;
  final String? token;

  static const empty = User(
    id: '',
    email: '',
    password: '',
    token: '',
  );

  const User({
    this.id,
    this.email,
    this.password,
    this.token,
  });

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        id,
        email,
        password,
        token,
      ];
}
