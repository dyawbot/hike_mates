import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/repo/app_repository.dart';
import 'package:hike_mates/features/domain/entity/user_emergency_contact_entity.dart';
import 'package:hike_mates/features/domain/parameters/user_contact_emergency_params.dart';

abstract class UserEmergencyContactRepository extends AppRepository {
  Future<ApiResult<List<UserEmergencyContactEntity>>>
      userEmergencyContactRepository(UserContactEmergencyParams? params);
  Future<ApiResult<UserEmergencyContactEntity>>
      updateUserEmergencyContactRepository(UserContactEmergencyParams params);
  Future<ApiResult<List<UserEmergencyContactEntity>>>
      deleteUserEmergencyContactRepository(DeleteNumberParams index);
}
