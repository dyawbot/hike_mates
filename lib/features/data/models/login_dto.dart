import 'package:hike_mates/features/data/models/app_dto.dart';
import 'package:hike_mates/features/domain/entity/app_entity.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto extends AppDto {
  final String username;
  final String? message;
  final String? token;

  LoginDto(this.username, {this.message, this.token});
  @override
  LoginEntity toEntity() => LoginEntity(username, token: token);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}

@JsonSerializable()
class LoginDtoS {
  LoginDto data;

  LoginDtoS(this.data);

  factory LoginDtoS.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoSFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDtoSToJson(this);
}
