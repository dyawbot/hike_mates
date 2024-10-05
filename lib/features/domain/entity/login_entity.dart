import 'package:floor/floor.dart';
import 'package:hike_mates/features/domain/entity/app_entity.dart';

@Entity(tableName: LoginEntity.tableName)
class LoginEntity extends AppEntity {
  @ignore
  static const String tableName = "user_login_tbl";
  @primaryKey
  final int primaryId = 1;
  final String username;
  final String? token;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  LoginEntity(this.username,
      {this.token,
      this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumber});
  @override
  List<Object?> get props =>
      [primaryId, username, token, userId, firstName, lastName, phoneNumber];
}
