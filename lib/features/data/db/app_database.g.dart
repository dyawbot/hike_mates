// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LoginDao? _loginDAOInstance;

  UserHikeCodeDao? _userHikeCodeDAOInstance;

  UserEmergencyContactDao? _userEmergencyContactDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 5,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_login_tbl` (`primaryId` INTEGER NOT NULL, `username` TEXT NOT NULL, `token` TEXT, `userId` INTEGER, `firstName` TEXT, `lastName` TEXT, `phoneNumber` TEXT, PRIMARY KEY (`primaryId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `hike_code_tbl` (`primaryId` INTEGER NOT NULL, `code` TEXT NOT NULL, `dateTime` TEXT NOT NULL, `userId` INTEGER, PRIMARY KEY (`primaryId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user_contact_emergency_tbl` (`primaryId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER NOT NULL, `contactName` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LoginDao get loginDAO {
    return _loginDAOInstance ??= _$LoginDao(database, changeListener);
  }

  @override
  UserHikeCodeDao get userHikeCodeDAO {
    return _userHikeCodeDAOInstance ??=
        _$UserHikeCodeDao(database, changeListener);
  }

  @override
  UserEmergencyContactDao get userEmergencyContactDAO {
    return _userEmergencyContactDAOInstance ??=
        _$UserEmergencyContactDao(database, changeListener);
  }
}

class _$LoginDao extends LoginDao {
  _$LoginDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _loginEntityInsertionAdapter = InsertionAdapter(
            database,
            'user_login_tbl',
            (LoginEntity item) => <String, Object?>{
                  'primaryId': item.primaryId,
                  'username': item.username,
                  'token': item.token,
                  'userId': item.userId,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'phoneNumber': item.phoneNumber
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LoginEntity> _loginEntityInsertionAdapter;

  @override
  Future<LoginEntity?> getLogin() async {
    return _queryAdapter.query('SELECT * FROM user_login_tbl',
        mapper: (Map<String, Object?> row) => LoginEntity(
            row['username'] as String,
            token: row['token'] as String?,
            userId: row['userId'] as int?,
            firstName: row['firstName'] as String?,
            lastName: row['lastName'] as String?,
            phoneNumber: row['phoneNumber'] as String?));
  }

  @override
  Future<LoginEntity?> getLoginById(int userId) async {
    return _queryAdapter.query('SELECT * FROM user_login_tbl WHERE userId=?1',
        mapper: (Map<String, Object?> row) => LoginEntity(
            row['username'] as String,
            token: row['token'] as String?,
            userId: row['userId'] as int?,
            firstName: row['firstName'] as String?,
            lastName: row['lastName'] as String?,
            phoneNumber: row['phoneNumber'] as String?),
        arguments: [userId]);
  }

  @override
  Future<void> deleteAllData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM user_login_tbl');
  }

  @override
  Future<void> insert(LoginEntity data) async {
    await _loginEntityInsertionAdapter.insert(data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAll(List<LoginEntity> data) async {
    await _loginEntityInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}

class _$UserHikeCodeDao extends UserHikeCodeDao {
  _$UserHikeCodeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userHikeCodeEntityInsertionAdapter = InsertionAdapter(
            database,
            'hike_code_tbl',
            (UserHikeCodeEntity item) => <String, Object?>{
                  'primaryId': item.primaryId,
                  'code': item.code,
                  'dateTime': item.dateTime,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserHikeCodeEntity>
      _userHikeCodeEntityInsertionAdapter;

  @override
  Future<UserHikeCodeEntity?> getUserHikeData() async {
    return _queryAdapter.query('SELECT * FROM hike_code_tbl',
        mapper: (Map<String, Object?> row) => UserHikeCodeEntity(
            row['code'] as String, row['dateTime'] as String,
            userId: row['userId'] as int?));
  }

  @override
  Future<void> deleteAllData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM hike_code_tbl');
  }

  @override
  Future<void> insert(UserHikeCodeEntity data) async {
    await _userHikeCodeEntityInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAll(List<UserHikeCodeEntity> data) async {
    await _userHikeCodeEntityInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}

class _$UserEmergencyContactDao extends UserEmergencyContactDao {
  _$UserEmergencyContactDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userEmergencyContactEntityInsertionAdapter = InsertionAdapter(
            database,
            'user_contact_emergency_tbl',
            (UserEmergencyContactEntity item) => <String, Object?>{
                  'primaryId': item.primaryId,
                  'userId': item.userId,
                  'contactName': item.contactName,
                  'phoneNumber': item.phoneNumber
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEmergencyContactEntity>
      _userEmergencyContactEntityInsertionAdapter;

  @override
  Future<List<UserEmergencyContactEntity>> getUserEmergencyData() async {
    return _queryAdapter.queryList('SELECT * FROM user_contact_emergency_tbl',
        mapper: (Map<String, Object?> row) => UserEmergencyContactEntity(
            row['contactName'] as String,
            row['phoneNumber'] as String,
            row['userId'] as int,
            primaryId: row['primaryId'] as int?));
  }

  @override
  Future<void> deleteAllData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM user_contact_emergency_tbl');
  }

  @override
  Future<UserEmergencyContactEntity?> updateEmergencyContact(
    int primaryId,
    String contactName,
    String phoneNumber,
  ) async {
    return _queryAdapter.query(
        'UPDATE user_contact_emergency_tbl      SET contactName = ?2,          phoneNumber = ?3     WHERE primaryId = ?1',
        mapper: (Map<String, Object?> row) => UserEmergencyContactEntity(row['contactName'] as String, row['phoneNumber'] as String, row['userId'] as int, primaryId: row['primaryId'] as int?),
        arguments: [primaryId, contactName, phoneNumber]);
  }

  @override
  Future<void> deleteByPhoneNumber(String phoneNumber) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM user_contact_emergency_tbl WHERE phoneNumber = ?1',
        arguments: [phoneNumber]);
  }

  @override
  Future<void> insert(UserEmergencyContactEntity data) async {
    await _userEmergencyContactEntityInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAll(List<UserEmergencyContactEntity> data) async {
    await _userEmergencyContactEntityInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}
