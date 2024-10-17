import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_status.g.dart';

@JsonSerializable()
class UserCredentialsStatus extends Equatable {
  final int code;
  final String message;

  const UserCredentialsStatus(this.code, this.message);

  factory UserCredentialsStatus.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsStatusFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialsStatusToJson(this);

  @override
  List<Object?> get props => [code, message];
}
