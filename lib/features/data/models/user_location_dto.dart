import 'package:hike_mates/features/data/models/app_dto.dart';

import 'package:hike_mates/features/domain/entity/user_location.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_location_dto.g.dart';

@JsonSerializable()
class UserLocationDto extends AppDto {
  final int? userId;
  final String? lo;
  final String? la;
  @JsonKey(name: 'hike_code')
  final String? hikeCode;
  @JsonKey(name: "user_alert_data")
  final String? userAlertData;
  final String? fullname;

  @JsonKey(name: "battery_status")
  final String? batteryStatus;

  UserLocationDto(
      {this.userId,
      this.lo,
      this.la,
      this.hikeCode,
      this.userAlertData,
      this.fullname,
      this.batteryStatus});
  // UserLocationDto({this.userId, this.la, this.lo, this.userAlertData});
  @override
  UserLocationEntity toEntity() => UserLocationEntity(
      userId: userId,
      lati: la,
      longi: lo,
      hikeCode: hikeCode,
      name: fullname,
      batteryStatus: batteryStatus);

  factory UserLocationDto.fromJson(Map<String, dynamic> json) =>
      _$UserLocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationDtoToJson(this);
}

@JsonSerializable()
class UserLocationDataDto {
  final String? message;
  final List<UserLocationDto>? data;

  UserLocationDataDto({this.message, this.data});

  factory UserLocationDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserLocationDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationDataDtoToJson(this);
}
