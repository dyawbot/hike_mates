import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hike_mates/features/data/dao/login_dao.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [LoginEntity],
)
abstract class AppDatabase extends FloorDatabase {
  static const int databaseWindow = 4096000;

  LoginDao get loginDAO;

  // Define migration from version 1 to version 2
  // static final migrationVersion1to2 = Migration(1, 2, (database) async {
  //   await database.execute(
  //       'ALTER TABLE ${PenroListEntity.tableName} ADD COLUMN classVsCover TEXT');

  // });

  static Future<AppDatabase> create() async =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
