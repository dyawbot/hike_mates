import 'package:floor/floor.dart';
import 'package:hike_mates/features/data/dao/app_dao.dart';
import 'package:hike_mates/features/data/db/app_database.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
@dao
abstract class LoginDao extends AppDao<LoginEntity> {
  @factoryMethod
  static LoginDao create(AppDatabase db) => db.loginDAO;

  @Query("SELECT * FROM ${LoginEntity.tableName}")
  Future<LoginEntity?> getLogin();

  @Query("DELETE FROM ${LoginEntity.tableName}")
  Future<void> deleteAllData();
}
