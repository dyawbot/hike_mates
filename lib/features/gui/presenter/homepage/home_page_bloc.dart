import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';
import 'package:hike_mates/features/domain/entity/user_location.dart';
import 'package:hike_mates/features/domain/parameters/hike_code_params.dart';
import 'package:hike_mates/features/domain/parameters/user_location_params.dart';
import 'package:hike_mates/features/domain/usecase/login_usecase.dart';
import 'package:hike_mates/features/domain/usecase/usecase.dart';
import 'package:hike_mates/features/domain/usecase/user_hike_code_usecase.dart';
import 'package:hike_mates/features/domain/usecase/user_location_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/api_result.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UserHikeCodeUsecase _userHikeCodeUsecase;
  final AllUserLocationUsecase _allUserLocationUsecase;
  final UserLocationUsecase _userLocationUsecase;
  final LogOutUsecase _logOutUsecase;

  HomePageBloc(this._userHikeCodeUsecase, this._allUserLocationUsecase,
      this._logOutUsecase, this._userLocationUsecase)
      : super(HomePageInitial()) {
    on<SaveHikeCodeEvent>((event, emit) async {
      emit(HomePageInitial());
      var result = await _userHikeCodeUsecase(event.params);

      var status = result.status;

      if (status == Status.success) {
        var data = result.data;

        if (data != null) {
          emit(HomeHikeCodeSuccessState(data));
        } else {
          emit(const HomePageErrorState("No data"));
        }
      } else {
        // var errorType = result.errorType;

        // if (errorType == ErrorType.emptyData) {
        // emit(HomeHikeCodeSuccessState(result.data!));
        // } else {
        emit(const HomePageErrorState("No data in db"));
        // }
      }
    });

    on<SaveUserLocationEvent>((event, emit) async {
      emit(HomePageInitial());

      var result = await _userLocationUsecase(event.params);
      var status = result.status;

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          emit(HomeSaveLocationState(result.data!));
        } else {
          emit(HomePageErrorState(result.message!));
        }
      } else {
        emit(HomePageErrorState(result.message!));
      }
    });
    on<CheckUserLocationEvent>((event, emit) async {
      emit(HomePageInitial());

      var result = await _allUserLocationUsecase(event.params);
      var status = result.status;

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          emit(HomeSaveAllLocationState(result.data!));
        } else {
          emit(HomePageErrorState(result.message!));
        }
      } else {
        var errorType = result.errorType;

        if (errorType == ErrorType.emptyData) {
          emit(HomeUserAllLocPageErrorState(ErrorType.emptyData.name));
        } else {
          emit(HomePageErrorState(result.message!));
        }
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(HomePageInitial());

      var result = await _logOutUsecase(NoParams());
      var status = result.status;

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          emit(const HomeLogoutState("OKAY"));
        } else {
          emit(HomePageErrorState(result.message!));
        }
      } else {
        var errorType = result.errorType;

        if (errorType == ErrorType.emptyData) {
          emit(HomeUserAllLocPageErrorState(ErrorType.emptyData.name));
        } else {
          emit(HomePageErrorState(result.message!));
        }
      }
    });
  }
}
