import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

import '../features/data/db/app_database.dart';
import 'app_module.config.dart';
// part "app_module.config.dart";

@module
abstract class AppModule {
  @Named("global")
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance();

  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  Dio get dio {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(minutes: 1),

      // validateStatus: (status) {
      //   return true;
      // },
    ));

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true; // Verify the certificate.
        };
        return client;
      },
    );

    return dio;
  }

  @preResolve
  Future<AppDatabase> get db => AppDatabase.create();
}

final getIt = _i1.GetIt.instance;
@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();
