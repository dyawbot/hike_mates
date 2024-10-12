import 'package:dio/dio.dart';
import 'package:hike_mates/features/data/models/user_location_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../common/web_urls.dart';

part 'user_location_api.g.dart';

@injectable
@RestApi(baseUrl: WebUrsl.url)
abstract class UserLocationApi {
  factory UserLocationApi(Dio dio, {String baseUrl}) = _UserLocationApi;

  @factoryMethod
  static create(Dio dio) => _UserLocationApi(dio);

  @POST("{url}/api/location_update.php")
  @FormUrlEncoded()
  Future<UserLocationDataDto> postUserLocationApi({
    @Path("url") required String url,
    @Field("lat") required String lati,
    @Field("long") required String longi,
    @Field("userId") required int userId,
    @Field("hikeCode") required String hikeCode,
    @Field("batteryStatus") required String batteryStatus,
    @Field("userDateLocUpdate") required userLocationUpdate,
  });
}
