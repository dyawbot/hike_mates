// ignore_for_file: prefer_final_fields

import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/repo/interface/user_emergency_contact_repository.dart';
import 'package:hike_mates/features/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../entity/user_emergency_contact_entity.dart';
import '../parameters/user_contact_emergency_params.dart';

@injectable
class UserEmergencyContactUsecase extends Usecase<
    Future<ApiResult<List<UserEmergencyContactEntity>>>,
    UserContactEmergencyParams> {
  UserEmergencyContactRepository _repository;

  UserEmergencyContactUsecase(this._repository);
  @override
  call(UserContactEmergencyParams? params) =>
      _repository.userEmergencyContactRepository(params);
}

@injectable
class UpdateUserEmergencyContactUsecase extends Usecase<
    Future<ApiResult<UserEmergencyContactEntity>>, UserContactEmergencyParams> {
  UserEmergencyContactRepository _repository;

  UpdateUserEmergencyContactUsecase(this._repository);
  @override
  call(UserContactEmergencyParams params) =>
      _repository.updateUserEmergencyContactRepository(params);
}

@injectable
class DeleteUserEmergencyContactUsecase extends Usecase<
    Future<ApiResult<List<UserEmergencyContactEntity>>>, DeleteNumberParams> {
  UserEmergencyContactRepository _repository;

  DeleteUserEmergencyContactUsecase(this._repository);
  @override
  call(DeleteNumberParams params) =>
      _repository.deleteUserEmergencyContactRepository(params);
}
