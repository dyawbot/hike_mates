import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hike_mates/features/data/dao/login_dao.dart';
import 'package:hike_mates/features/data/dao/user_emergency_contact_dao.dart';
import 'package:hike_mates/features/data/dao/user_hike_code_dao.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/entity/user_emergency_contact_entity.dart';
import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(
  version: 5,
  entities: [LoginEntity, UserHikeCodeEntity, UserEmergencyContactEntity],
)
abstract class AppDatabase extends FloorDatabase {
  static const int databaseWindow = 4096000;

  LoginDao get loginDAO;
  UserHikeCodeDao get userHikeCodeDAO;
  UserEmergencyContactDao get userEmergencyContactDAO;

  // Define migration from version 1 to version 2
  static final migrationVersion1to2 = Migration(1, 2, (database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS ${UserHikeCodeEntity.tableName} (
      primaryId INTEGER PRIMARY KEY,
      code TEXT NOT NULL,
      dateTime TEXT NOT NULL
    )
  ''');
  });

  static final migrationVersion2to3 = Migration(2, 3, (database) async {
    await database.execute('''
        ALTER TABLE ${LoginEntity.tableName}  ADD COLUMN firstName TEXT;
      ''');
    await database.execute('''
        ALTER TABLE ${LoginEntity.tableName} ADD COLUMN lastName TEXT;
      ''');
    await database.execute('''
        ALTER TABLE ${LoginEntity.tableName} ADD COLUMN phoneNumber TEXT;
      ''');
  });

  static final migrationVersion3to4 = Migration(3, 4, (database) async {
    await database.execute('''
        ALTER TABLE ${UserHikeCodeEntity.tableName}  ADD COLUMN userId INTEGER;
      ''');
  });

  static final migrationVersion4to5 = Migration(4, 5, (database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS ${UserEmergencyContactEntity.tableName} (
      primaryId INTEGER PRIMARY KEY AUTOINCREMENT,
      contactName TEXT NOT NULL,
      phoneNumber TEXT NOT NULL,
      userId INTEGER NOT NULL
    )
  ''');
  });

  static Future<AppDatabase> create() async =>
      $FloorAppDatabase.databaseBuilder('app_database.db').addMigrations([
        migrationVersion1to2
      ]).addMigrations([migrationVersion2to3]).addMigrations(
          [migrationVersion3to4]).addMigrations([migrationVersion4to5]).build();
}
