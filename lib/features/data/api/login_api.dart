import 'dart:math';

import 'package:dio/dio.dart';
import 'package:hike_mates/common/web_urls.dart';
import 'package:hike_mates/features/data/models/login_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/http.dart';
import 'dart:convert';

part 'login_api.g.dart';

@injectable
@RestApi(baseUrl: WebUrsl.url)
abstract class LoginApi {
  factory LoginApi(Dio dio, {String baseUrl}) = _LoginApi;

  @factoryMethod
  static create(Dio dio) => LoginApi(dio);

  @POST("{url}/api/login.php")
  @FormUrlEncoded()
  // @Header('Content-Type: application/x-www-form-urlencoded')
  Future<LoginDto> getLoginCredentials({
    @Path("url") required String url,
    @Field("username") required String username,
    @Field("password") required String password,
  });
}
