import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/entity/user_hike_code_entity.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';
import 'package:hike_mates/features/domain/usecase/login_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/api_result.dart';
import '../../../domain/parameters/hike_code_params.dart';
import '../../../domain/usecase/user_hike_code_usecase.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

@injectable
class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final LoginUsecase _loginUsecase;
  final UserHikeCodeUsecase _userHikeCodeUsecase;

  LoginPageBloc(this._loginUsecase, this._userHikeCodeUsecase)
      : super(LoginPageInitial()) {
    on<GetLoginEvent>((event, emit) async {
      emit(LoginPageLoadingState());

      var result = await _loginUsecase(event.params);

      var status = result.status;

      if (status == Status.success) {
        var data = result.data;

        if (data != null) {
          emit(LoginPageSuccessState(data));
        } else {
          emit(LoginPageErrorState(message: result.message));
        }
      } else if (status == Status.loading) {
        emit(LoginPageInitial());
      } else {
        var errorType = result.errorType;
        if (errorType == ErrorType.noInternet) {
          emit(LoginPageInternetErrorState(message: result.message));
        } else {
          emit(LoginPageErrorState(message: result.message));
        }
      }
    });

    on<SaveHikeCodeEvent>((event, emit) async {
      emit(LoginPageInitial());
      var result = await _userHikeCodeUsecase(event.params);

      var status = result.status;

      if (status == Status.success) {
        var data = result.data;

        if (data != null) {
          emit(HikeCodeSuccessState(data));
        } else {
          emit(const LoginPageErrorState(message: "No data"));
        }
      } else {
        // var errorType = result.errorType;

        // if (errorType == ErrorType.emptyData) {
        // emit(HomeHikeCodeSuccessState(result.data!));
        // } else {
        emit(const LoginPageErrorState(message: "No data in db"));
        // }
      }
    });
  }
}
