import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/repo/app_repository.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';
import 'package:hike_mates/features/domain/parameters/hike_code_params.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';

abstract class SessionRepository extends AppRepository {
  Future<ApiResult<LoginEntity>> loginRepository(LoginParams? params);
  Future<ApiResult<LoginEntity>> logOutRepository();
  Future<ApiResult<UserHikeCodeEntity>> userHikeCode(HikeCodeParams? params);
}
