import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hike_mates/features/data/models/login_dto.dart';
import 'package:hike_mates/features/data/api/login_api.dart';

import 'login_api_test.mocks.dart';

// Generate mock class
@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late LoginApi loginApi;

  setUp(() {
    // Initialize the mock Dio instance
    // mockDio = MockDio();

    // // Initialize the LoginApi with the mocked Dio
    // loginApi = LoginApi(mockDio);

    mockDio = MockDio();

    // Stub the `options` method.
    when(mockDio.options).thenReturn(BaseOptions());

    loginApi = LoginApi(mockDio);
  });

  test('LoginApi - should return valid LoginDto on success', () async {
    // Define the mock API response
    final mockResponseData = {
      "username": "admin",
      "token": "ee28fda6850230a890a9ada08a8f19d3",
    };

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var data = {'username': 'admin', 'password': 'admin'};
    var dio = Dio();
    var response = await dio.request(
      'https://www.hikemates.online/hike_mates/api/login.php',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      LoginDto loginDto = LoginDto.fromJson(json.decode(response.data));
      print(loginDto);
    } else {
      print(response.statusMessage);
    }

    // print(result);

    // Check if the result matches the expected output
    // expect(result.username, "admin");
    // expect(result.token, "ee28fda6850230a890a9ada08a8f19d3");
  });
}
