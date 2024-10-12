import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/features/data/dao/login_dao.dart';
import 'package:hike_mates/features/data/dao/user_emergency_contact_dao.dart';

import 'package:hike_mates/features/data/repo/interface/user_emergency_contact_repository.dart';
import 'package:hike_mates/features/domain/entity/user_emergency_contact_entity.dart';
import 'package:hike_mates/features/domain/parameters/user_contact_emergency_params.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: UserEmergencyContactRepository)
class UserEmergencyContactRepoImpl extends UserEmergencyContactRepository {
  final UserEmergencyContactDao userEmergencyContactDao;
  final LoginDao loginDao;
  final logger = Logger();
  UserEmergencyContactRepoImpl(this.userEmergencyContactDao, this.loginDao);
  @override
  Future<ApiResult<List<UserEmergencyContactEntity>>>
      userEmergencyContactRepository(UserContactEmergencyParams? params) async {
    //variable on db

    var localData = await userEmergencyContactDao.getUserEmergencyData();
    var userData = await loginDao.getLogin();

    if (params != null) {
      if (userData!.userId != params.userId) {
        await userEmergencyContactDao.deleteAllData();
      }

      // var userData = await loginDao.getLogin();
      var paramsData = UserEmergencyContactEntity(params.contactName,
          params.phoneNumber, params.imageFileName, userData.userId!);

      await userEmergencyContactDao.insert(paramsData);
      logger.d("asdasdsfadfgadsg");
      return ApiResult.success(
          await userEmergencyContactDao.getUserEmergencyData());
    } else {
      logger.d("ASDASDASDASDASDASd");
      return ApiResult.success(localData);
    }
  }

  @override
  Future<ApiResult<List<UserEmergencyContactEntity>>>
      deleteUserEmergencyContactRepository(DeleteNumberParams index) async {
    logger.d("ASFDASFBSDFJKHGSDHKUFGBSDKFGVSDLUHGFVSLDHUFBSD");
    await userEmergencyContactDao.deleteByPhoneNumber(index.index);

    var data = await userEmergencyContactDao.getUserEmergencyData();
    logger.d(data);
    return ApiResult.success(data);
  }

  @override
  Future<ApiResult<UserEmergencyContactEntity>>
      updateUserEmergencyContactRepository(
          UserContactEmergencyParams params) async {
    var data = await userEmergencyContactDao.updateEmergencyContact(
        params.userId, params.contactName, params.phoneNumber);

    return ApiResult.success(data);
  }
}
