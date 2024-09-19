import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../common/api_result.dart';

abstract class AppRepository {
  ApiResult<T> parseError<T>(DioException e, {T? data}) {
    if (e.type == DioErrorType.unknown) {
      var err = e.error;
      print("ON APP REPOSITORY $err");
      print("***************** message ${e.message}");
      print("***************** response ${e.response}");
      if (err is SocketException) {
        log("SocketException: ${e.message}");
        if (err.osError?.errorCode == 101) {
          print(err.osError?.errorCode);
          return ApiResult.connectionFailed(data: data);
        }
      }

      if (err is HttpException) {
        log("HttpException: ${e.message}");
        print(err.uri);
      }
    }
    log("${runtimeType.toString()}: ${e.message}", stackTrace: e.stackTrace);
    if (e.type == DioErrorType.connectionTimeout) {
      return ApiResult.error("Connection Timeout. Please try again",
          data: data);
    }
    if ([403].contains(e.response?.statusCode)) {
      return ApiResult.sessionExpired(data: data);
    }
    if ([400].contains(e.response?.statusCode)) {
      var response = e.response!.data.toString();
      if (response.contains("ValidationError")) {
        var res = response.split("ValidationError: (u")[1];
        RegExp exp = RegExp("'(.*?)'");
        var result = exp.stringMatch(res) ?? "''";
        result = (result.substring(1, result.length - 1));
        return ApiResult.error(result, data: data);
      }
      return ApiResult.error(e.message, data: data);
    } else {
      return ApiResult.error(e.message, data: data);
    }
  }
}
