// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentials _$UserCredentialsFromJson(Map<String, dynamic> json) =>
    UserCredentials(
      token: json['token'] as String?,
      id: json['id'] as String?,
      status: json['status'] == null
          ? null
          : UserCredentialsStatus.fromJson(
              json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCredentialsToJson(UserCredentials instance) =>
    <String, dynamic>{
      'token': instance.token,
      'id': instance.id,
      'status': instance.status,
    };
