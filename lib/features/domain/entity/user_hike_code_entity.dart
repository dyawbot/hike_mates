import 'package:floor/floor.dart';
import 'package:hike_mates/features/domain/entity/app_entity.dart';

@Entity(tableName: UserHikeCodeEntity.tableName)
class UserHikeCodeEntity extends AppEntity {
  @ignore
  static const String tableName = "hike_code_tbl";

  @primaryKey
  final primaryId = 1;
  final String code;
  final String dateTime;
  final int? userId;

  UserHikeCodeEntity(this.code, this.dateTime, {this.userId});

  @override
  List<Object?> get props => [code, dateTime, userId];
}
