import 'package:hike_mates/common/api_result.dart';
import 'package:hike_mates/common/web_urls.dart';
import 'package:hike_mates/features/data/api/get_all_location_api.dart';
import 'package:hike_mates/features/data/api/user_location_api.dart';
import 'package:hike_mates/features/data/repo/interface/user_location_repository.dart';
import 'package:hike_mates/features/domain/entity/user_location.dart';
import 'package:hike_mates/features/domain/parameters/user_location_params.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

@Injectable(as: UserLocationRepository)
class UserLocationRepoImpl extends UserLocationRepository {
  final UserLocationApi userLocationApi;
  final GetAllLocationApi getAllLocationApi;
  DateTime now = DateTime.now();
  final logger = Logger();

  UserLocationRepoImpl(this.userLocationApi, this.getAllLocationApi);
  @override
  Future<ApiResult<List<UserLocationEntity>>> postUserLocation(
      UserLocationParams params) async {
    //! always saves the data

    String url = WebUrsl.url;

    DateFormat formatter = DateFormat('dd.MM.yyyy-HH:mm');
    String formattedDate = formatter.format(now);
    try {
      logger.d(params);
      var response = await userLocationApi.postUserLocationApi(
          url: url,
          lati: params.lati,
          longi: params.longi,
          hikeCode: params.hikeCode,
          userId: params.userId!,
          userLocationUpdate: formattedDate);

      if (response.message != null) {
        if (response.data != null) {
          var message = response.message!;
          var data = response.data!
              .map(
                (e) => e.toEntity(),
              )
              .toList();

          // logger.d(data);

          if (message == "Data retrieved successfully.") {
            return ApiResult.success(data);
          } else {
            logger.e(message);
            return ApiResult.error(message);
          }
        } else {
          logger.e(response.message);

          return ApiResult.error(response.message!);
        }
      } else {
        logger.e("FAILLED TO UPDATE");

        return const ApiResult.error("Failed to update location");
      }
    } on Exception catch (e) {
      // logger.e(e);

      return ApiResult.error(e.toString());
    }
  }

  @override
  Future<ApiResult<List<UserLocationEntity>>> getAllUserLocation(
      CheckHikeUserParams params) async {
    String url = WebUrsl.url;
    if (params.hikeCode != null) {
      // logger.d(params.hikeCode);
      // logger.d(params.userId);
      try {
        var response = await getAllLocationApi.getAllUserLocationApi(
          url: url,
          hikeCode: params.hikeCode!,
          userId: params.userId,
        );

        if (response.message != null) {
          if (response.data != null) {
            var message = response.message!;
            // for (var i in response.data!) {
            //   logger.d(i.fullname);
            // }
            var data = response.data!.map((e) => e.toEntity()).toList();

            if (message == "Data retrieved successfully.") {
              return ApiResult.success(data);
            } else {
              // logger.e(message);
              return ApiResult.error(message);
            }
          } else {
            // logger.e(response.message);

            return ApiResult.error(response.message!);
          }
        } else {
          logger.e("FAILLED TO UPDATE");

          return const ApiResult.error("Failed to update location");
        }
      } on Exception catch (e) {
        // logger.e(e);

        return ApiResult.error(e.toString());
      }
    } else {
      return const ApiResult.error("No params", errorType: ErrorType.emptyData);
    }
  }
}
