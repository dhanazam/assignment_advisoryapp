import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String token;

  const User({
    required this.id,
    required this.token,
  });

  @override
  List<Object> get props => [id, token];
}
