import 'package:floor/floor.dart';
import 'package:hike_mates/features/data/dao/app_dao.dart';
import 'package:hike_mates/features/domain/entity/user_emergency_contact_entity.dart';
import 'package:injectable/injectable.dart';

import '../db/app_database.dart';

@dao
@injectable
abstract class UserEmergencyContactDao
    extends AppDao<UserEmergencyContactEntity> {
  @factoryMethod
  static UserEmergencyContactDao create(AppDatabase db) =>
      db.userEmergencyContactDAO;

  @Query("SELECT * FROM ${UserEmergencyContactEntity.tableName}")
  Future<List<UserEmergencyContactEntity>> getUserEmergencyData();

  @Query("DELETE FROM ${UserEmergencyContactEntity.tableName}")
  Future<void> deleteAllData();

  @Query('''
    UPDATE ${UserEmergencyContactEntity.tableName} 
    SET contactName = :contactName, 
        phoneNumber = :phoneNumber
    WHERE primaryId = :primaryId
  ''')
  Future<UserEmergencyContactEntity?> updateEmergencyContact(
      int primaryId, String contactName, String phoneNumber);

  @Query(
      "DELETE FROM ${UserEmergencyContactEntity.tableName} WHERE phoneNumber = :phoneNumber")
  Future<void> deleteByPhoneNumber(String phoneNumber);
}
