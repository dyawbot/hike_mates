import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/repo/interface/session_repository.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';
import 'package:hike_mates/features/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase
    extends Usecase<Future<ApiResult<LoginEntity>>, LoginParams> {
  final SessionRepository _repository;

  LoginUsecase(this._repository);
  @override
  call(LoginParams? params) => _repository.loginRepository(params);
}

@injectable
class LogOutUsecase extends Usecase<Future<ApiResult<LoginEntity>>, NoParams> {
  final SessionRepository _repository;

  LogOutUsecase(this._repository);
  @override
  call(NoParams params) => _repository.logOutRepository();
}
