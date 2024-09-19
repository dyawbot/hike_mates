// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
      json['username'] as String,
      message: json['message'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
      'username': instance.username,
      'message': instance.message,
      'token': instance.token,
    };

LoginDtoS _$LoginDtoSFromJson(Map<String, dynamic> json) => LoginDtoS(
      LoginDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDtoSToJson(LoginDtoS instance) => <String, dynamic>{
      'data': instance.data,
    };
