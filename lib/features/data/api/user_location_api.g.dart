// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _UserLocationApi implements UserLocationApi {
  _UserLocationApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.hikemates.online/hike_mates';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserLocationDataDto> postUserLocationApi({
    required String url,
    required String lati,
    required String longi,
    required int userId,
    required String hikeCode,
    required dynamic userLocationUpdate,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'lat': lati,
      'long': longi,
      'userId': userId,
      'hikeCode': hikeCode,
      'userDateLocUpdate': userLocationUpdate,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserLocationDataDto>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '${url}/api/location_update.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserLocationDataDto.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
