import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';
import 'package:hike_mates/features/domain/usecase/login_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/api_result.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

@injectable
class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final LoginUsecase _loginUsecase;

  LoginPageBloc(this._loginUsecase) : super(LoginPageInitial()) {
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
  }
}
