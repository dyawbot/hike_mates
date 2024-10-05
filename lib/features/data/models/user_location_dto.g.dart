// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationDto _$UserLocationDtoFromJson(Map<String, dynamic> json) =>
    UserLocationDto(
      userId: (json['userId'] as num?)?.toInt(),
      lo: json['lo'] as String?,
      la: json['la'] as String?,
      hikeCode: json['hike_code'] as String?,
      userAlertData: json['user_alert_data'] as String?,
      fullname: json['fullname'] as String?,
    );

Map<String, dynamic> _$UserLocationDtoToJson(UserLocationDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'lo': instance.lo,
      'la': instance.la,
      'hike_code': instance.hikeCode,
      'user_alert_data': instance.userAlertData,
      'fullname': instance.fullname,
    };

UserLocationDataDto _$UserLocationDataDtoFromJson(Map<String, dynamic> json) =>
    UserLocationDataDto(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserLocationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserLocationDataDtoToJson(
        UserLocationDataDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
