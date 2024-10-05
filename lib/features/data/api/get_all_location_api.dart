import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../common/web_urls.dart';
import '../models/user_location_dto.dart';
part 'get_all_location_api.g.dart';

@injectable
@RestApi(baseUrl: WebUrsl.url)
abstract class GetAllLocationApi {
  factory GetAllLocationApi(Dio dio, {String baseUrl}) = _GetAllLocationApi;

  @factoryMethod
  static create(Dio dio) => _GetAllLocationApi(dio);

  @POST("{url}/api/location.php")
  @FormUrlEncoded()
  Future<UserLocationDataDto> getAllUserLocationApi({
    @Path("url") required String url,
    @Field("userId") required int userId,
    @Field("hikeCode") required String hikeCode,
  });
}
