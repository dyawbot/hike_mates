import 'package:floor/floor.dart';
import 'package:hike_mates/features/domain/entity/app_entity.dart';

@Entity(tableName: UserEmergencyContactEntity.tableName)
class UserEmergencyContactEntity extends AppEntity {
  @ignore
  static const String tableName = 'user_contact_emergency_tbl';

  @PrimaryKey(autoGenerate: true)
  final int? primaryId;
  final int userId;
  final String contactName;
  final String phoneNumber;
  final String imageFileName;

  UserEmergencyContactEntity(
    this.contactName,
    this.phoneNumber,
    this.imageFileName,
    this.userId, {
    this.primaryId,
  });
  @override
  List<Object?> get props => [
        primaryId,
        contactName,
        phoneNumber,
        userId,
        imageFileName,
      ];
}
