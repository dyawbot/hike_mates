// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
      json['username'] as String,
      message: json['message'] as String?,
      token: json['token'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
      'username': instance.username,
      'message': instance.message,
      'token': instance.token,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
    };
