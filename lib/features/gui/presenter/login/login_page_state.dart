part of 'login_page_bloc.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();
}

class LoginPageInitial extends LoginPageState {
  @override
  List<Object> get props => [];
}

class LoginPageLoadingState extends LoginPageState {
  @override
  List<Object> get props => [];
}

class LoginPageSuccessState extends LoginPageState {
  final LoginEntity loginEntity;
  const LoginPageSuccessState(this.loginEntity);
  @override
  List<Object> get props => [loginEntity];
}

class LoginPageInternetErrorState extends LoginPageState {
  final String? message;
  const LoginPageInternetErrorState({this.message});
  @override
  List<Object?> get props => [message];
}

class LoginPageErrorState extends LoginPageState {
  final String? message;
  const LoginPageErrorState({this.message});
  @override
  List<Object?> get props => [message];
}

class HikeCodeErrorState extends LoginPageState {
  final String? message;
  const HikeCodeErrorState({this.message});
  @override
  List<Object?> get props => [message];
}

class HikeCodeSuccessState extends LoginPageState {
  final UserHikeCodeEntity codeEntity;
  const HikeCodeSuccessState(this.codeEntity);

  @override
  List<Object?> get props => [codeEntity];
}
