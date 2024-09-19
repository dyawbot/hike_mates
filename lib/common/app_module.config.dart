// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hike_mates/common/app_module.dart' as _i994;
import 'package:hike_mates/features/data/api/login_api.dart' as _i758;
import 'package:hike_mates/features/data/dao/login_dao.dart' as _i462;
import 'package:hike_mates/features/data/db/app_database.dart' as _i558;
import 'package:hike_mates/features/data/repo/impl/session_repo_impl.dart'
    as _i945;
import 'package:hike_mates/features/data/repo/interface/session_repository.dart'
    as _i871;
import 'package:hike_mates/features/domain/usecase/login_usecase.dart' as _i919;
import 'package:hike_mates/features/gui/presenter/login/login_page_bloc.dart'
    as _i928;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i558.AppDatabase>(
      () => appModule.db,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => appModule.httpClient);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => appModule.internetConnectionChecker,
      instanceName: 'global',
    );
    gh.factory<_i758.LoginApi>(() => _i758.LoginApi.create(gh<_i361.Dio>()));
    gh.factory<_i462.LoginDao>(
        () => _i462.LoginDao.create(gh<_i558.AppDatabase>()));
    gh.factory<_i871.SessionRepository>(() => _i945.SessionRepoImpl(
          gh<_i758.LoginApi>(),
          gh<_i462.LoginDao>(),
          gh<_i973.InternetConnectionChecker>(instanceName: 'global'),
        ));
    gh.factory<_i919.LoginUsecase>(
        () => _i919.LoginUsecase(gh<_i871.SessionRepository>()));
    gh.factory<_i928.LoginPageBloc>(
        () => _i928.LoginPageBloc(gh<_i919.LoginUsecase>()));
    return this;
  }
}

class _$AppModule extends _i994.AppModule {}
