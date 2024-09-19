import 'package:dio/dio.dart';
import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/common/web_urls.dart';
import 'package:hike_mates/features/data/api/login_api.dart';
import 'package:hike_mates/features/data/dao/login_dao.dart';
import 'package:hike_mates/features/data/models/login_dto.dart';
import 'package:hike_mates/features/data/repo/interface/session_repository.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

@Injectable(as: SessionRepository)
class SessionRepoImpl extends SessionRepository {
  final Logger logger = Logger();
  final LoginApi loginApi;
  final LoginDao loginDao;
  final InternetConnectionChecker _internetConnectionChecker;

  SessionRepoImpl(this.loginApi, this.loginDao,
      @Named('global') this._internetConnectionChecker);
  @override
  Future<ApiResult<LoginEntity>> loginRepository(LoginParams? params) async {
    var localLoginData = await loginDao.getLogin();
    String url = WebUrsl.url;
    //* check if the internet is available
    if (!(await _internetConnectionChecker.hasConnection)) {
      return ApiResult.error('No internet connection');
    } else {
      //*check if loginParams is empty. if empty rekta login
      if (params != null && localLoginData == null) {
        try {
          // var response = await apiResult(url, params.username, params.password);
          var response = await loginApi.getLoginCredentials(
              url: url, username: params.username, password: params.password);

          var entity = response.toEntity();
          await loginDao.insert(entity);

          return ApiResult.success(await loginDao.getLogin());
        } on DioException catch (e) {
          logger.f(e);
          return ApiResult.error(e.message);
        } on Exception catch (e) {
          logger.e(e);
          return ApiResult.error(e.toString());
        }
      } else if (params == null && localLoginData != null) {
        return ApiResult.success(localLoginData);
      } else {
        return ApiResult.loading();
      }
    }
    // TODO: implement loginRepository
    // throw UnimplementedError();
  }

  // Future<LoginDto> apiResult(
  //     String url, String username, String password) async {
  //   try {
  //     var response = await loginApi.getLoginCredentials(
  //         url: url, username: username, password: password);
  //     // var data = LoginDto(response.data.username, token: response.data.token);
  //     return response;
  //   } on DioException catch (e) {
  //     logger.e(e);
  //     logger.e(e.requestOptions.uri);
  //     throw DioException(requestOptions: RequestOptions());
  //   } on Exception catch (e) {
  //     // TODO
  //     logger.e(e);
  //     throw Exception(e);
  //   }
  // }
}
