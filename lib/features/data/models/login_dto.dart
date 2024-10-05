import 'package:hike_mates/features/data/models/app_dto.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto extends AppDto {
  final String username;
  final String? message;
  final String? token;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  LoginDto(this.username,
      {this.message,
      this.token,
      this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumber});
  @override
  LoginEntity toEntity() => LoginEntity(username,
      token: token,
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
