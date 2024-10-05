import 'package:dio/dio.dart';
import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/common/web_urls.dart';
import 'package:hike_mates/features/data/api/login_api.dart';
import 'package:hike_mates/features/data/dao/login_dao.dart';
import 'package:hike_mates/features/data/dao/user_hike_code_dao.dart';
import 'package:hike_mates/features/data/repo/interface/session_repository.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';
import 'package:hike_mates/features/domain/parameters/hike_code_params.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

@Injectable(as: SessionRepository)
class SessionRepoImpl extends SessionRepository {
  final Logger logger = Logger();
  final LoginApi loginApi;
  final LoginDao loginDao;
  final UserHikeCodeDao userHikeCodeDao;
  final InternetConnectionChecker _internetConnectionChecker;

  SessionRepoImpl(this.loginApi, this.loginDao, this.userHikeCodeDao,
      @Named('global') this._internetConnectionChecker);
  @override
  Future<ApiResult<LoginEntity>> loginRepository(LoginParams? params) async {
    var localLoginData = await loginDao.getLogin();

    String url = WebUrsl.url;
    //* check if the internet is available
    if (!(await _internetConnectionChecker.hasConnection)) {
      return const ApiResult.error('No internet connection');
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
          return const ApiResult.error(
              "Both the email and password are incorrect, or one of them is wrong, or they may not exist in the database.");
        } on Exception catch (e) {
          logger.e(e);
          return ApiResult.error(e.toString());
        }
      } else if (params == null && localLoginData != null) {
        return ApiResult.success(localLoginData);
      } else {
        return const ApiResult.loading();
      }
    }

    // throw UnimplementedError();
  }

  @override
  Future<ApiResult<UserHikeCodeEntity>> userHikeCode(
      HikeCodeParams? params) async {
    // Use 12-hour format with AM/PM
    DateTime timeNow = DateTime.now();
    DateFormat formatter = DateFormat('dd.MM.yyyy-HH:mm');

    // Format the current time to string
    String formattedTime = formatter.format(timeNow).toLowerCase();

    var localData = await userHikeCodeDao.getUserHikeData();
    var checkLoginChange = await loginDao.getLogin();

    int days = 2;
    int millisecondsInOneDay = 24 * 60 * 60 * 1000;
    int result = days * millisecondsInOneDay;

    if (localData != null && params != null) {
      var logInData = await loginDao.getLogin();

      var entity = UserHikeCodeEntity(params.code, formattedTime,
          userId: logInData!.userId);
      await userHikeCodeDao.insert(entity);

      return ApiResult.success(entity);
    } else if (localData != null && params == null) {
      // Ensure you use the same formatter when parsing the saved date

      DateTime parsedDateTimeSaved = formatter.parse(localData.dateTime);
      DateTime parsedDateTimeNow = formatter.parse(formattedTime);

      // Convert DateTime to milliseconds since epoch
      int millisTimeSaved = parsedDateTimeSaved.millisecondsSinceEpoch;
      int millisTimeNow = parsedDateTimeNow.millisecondsSinceEpoch;

      int addedTime = millisTimeSaved + result;

      if (millisTimeNow > addedTime) {
        // Reset if the time has expired

        await userHikeCodeDao.deleteAllData();
        return const ApiResult.error("Need to update the code");
      } else {
        //check loginif changed
        if (checkLoginChange == null) {
          await userHikeCodeDao.deleteAllData();
          var entity = UserHikeCodeEntity("Hike Code", formattedTime);
          await userHikeCodeDao.insert(entity);
        }

        return ApiResult.success(await userHikeCodeDao.getUserHikeData());
      }
    } else if (params == null && localData == null) {
      var entity = UserHikeCodeEntity("Hike Code", formattedTime);
      await userHikeCodeDao.insert(entity);

      return ApiResult.success(entity);
    } else {
      return const ApiResult.error("Ignored", errorType: ErrorType.emptyData);
    }
  }

  @override
  Future<ApiResult<LoginEntity>> logOutRepository() async {
    var localData = await loginDao.getLogin();

    if (localData != null) {
      await loginDao.deleteAllData();

      var result = await loginDao.getLogin();
      logger.d(result);
      return ApiResult.success(localData);
    } else {
      return const ApiResult.error("Ignored", errorType: ErrorType.emptyData);
    }
  }
}
