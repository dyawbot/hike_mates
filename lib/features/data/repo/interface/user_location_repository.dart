import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/repo/app_repository.dart';
import 'package:hike_mates/features/domain/entity/user_location.dart';
import 'package:hike_mates/features/domain/parameters/user_location_params.dart';

abstract class UserLocationRepository extends AppRepository {
  Future<ApiResult<List<UserLocationEntity>>> postUserLocation(
      UserLocationParams params);

  Future<ApiResult<List<UserLocationEntity>>> getAllUserLocation(
      CheckHikeUserParams params);
  // Future<ApiResult<List<UserLocationEntity>>> getUserLocation(
  //     UserLocationHideCodeParams params);
}
