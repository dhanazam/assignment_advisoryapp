// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialsStatus _$UserCredentialsStatusFromJson(
        Map<String, dynamic> json) =>
    UserCredentialsStatus(
      (json['code'] as num).toInt(),
      json['message'] as String,
    );

Map<String, dynamic> _$UserCredentialsStatusToJson(
        UserCredentialsStatus instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
