// ignore_for_file: unused_field

import 'package:hike_mates/common/api_result.dart';

import 'package:hike_mates/features/data/repo/interface/session_repository.dart';
import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';
import 'package:hike_mates/features/domain/parameters/hike_code_params.dart';

import 'package:injectable/injectable.dart';

import 'usecase.dart';

@injectable
class UserHikeCodeUsecase
    extends Usecase<Future<ApiResult<UserHikeCodeEntity>>, HikeCodeParams> {
  final SessionRepository _repository;

  UserHikeCodeUsecase(this._repository);
  @override
  call(HikeCodeParams? params) => _repository.userHikeCode(params);
}
