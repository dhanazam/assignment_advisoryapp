import 'package:authentication_repository/src/models/user_credentials_status.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_credentials.g.dart';

@JsonSerializable()
class UserCredentials extends Equatable {
  final String? token;
  final String? id;
  final UserCredentialsStatus? status;

  static const empty = UserCredentials(
    token: null,
  );

  const UserCredentials({
    this.token,
    this.id,
    this.status,
  });

  UserCredentials copyWith({
    String? token,
    String? id,
    Map<String, dynamic>? status,
  }) {
    return UserCredentials(
      token: token ?? this.token,
      id: id ?? this.id,
      status:
          status == null ? this.status : UserCredentialsStatus.fromJson(status),
    );
  }

  factory UserCredentials.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialsToJson(this);

  @override
  List<Object?> get props => [token, id, status];
}
