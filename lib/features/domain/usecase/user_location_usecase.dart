import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/repo/interface/user_location_repository.dart';
import 'package:hike_mates/features/domain/parameters/user_location_params.dart';
import 'package:hike_mates/features/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entity/user_location.dart';

@injectable
class UserLocationUsecase extends Usecase<
    Future<ApiResult<List<UserLocationEntity>>>, UserLocationParams> {
  final UserLocationRepository _locationRepository;

  UserLocationUsecase(this._locationRepository);
  @override
  call(UserLocationParams params) =>
      _locationRepository.postUserLocation(params);
}

@injectable
class AllUserLocationUsecase extends Usecase<
    Future<ApiResult<List<UserLocationEntity>>>, CheckHikeUserParams> {
  final UserLocationRepository _locationRepository;

  AllUserLocationUsecase(this._locationRepository);
  @override
  call(CheckHikeUserParams params) =>
      _locationRepository.getAllUserLocation(params);
}
