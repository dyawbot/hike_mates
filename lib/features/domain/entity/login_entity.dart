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

  LoginEntity(this.username, {this.token});
  @override
  // TODO: implement props
  List<Object?> get props => [primaryId, username, token];
}
