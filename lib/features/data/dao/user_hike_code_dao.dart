import 'package:floor/floor.dart';
import 'package:hike_mates/features/data/dao/app_dao.dart';
import 'package:hike_mates/features/data/db/app_database.dart';

import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
@dao
abstract class UserHikeCodeDao extends AppDao<UserHikeCodeEntity> {
  @factoryMethod
  static UserHikeCodeDao create(AppDatabase db) => db.userHikeCodeDAO;

  @Query("SELECT * FROM ${UserHikeCodeEntity.tableName}")
  Future<UserHikeCodeEntity?> getUserHikeData();

  @Query("DELETE FROM ${UserHikeCodeEntity.tableName}")
  Future<void> deleteAllData();
}
