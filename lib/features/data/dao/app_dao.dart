//THIS APP DAO IS FOR CRUD
import 'package:floor/floor.dart';

import '../../domain/entity/app_entity.dart';

abstract class AppDao<T extends AppEntity> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(T data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<T> data);

  // @Delete(onConflict: OnConflictStrategy.replace)
  // Future<void> insertAll(List<T> data);
}
