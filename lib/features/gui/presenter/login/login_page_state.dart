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
  LoginPageSuccessState(this.loginEntity);
  @override
  List<Object> get props => [loginEntity];
}

class LoginPageInternetErrorState extends LoginPageState {
  final String? message;
  LoginPageInternetErrorState({this.message});
  @override
  List<Object?> get props => [message];
}

class LoginPageErrorState extends LoginPageState {
  final String? message;
  LoginPageErrorState({this.message});
  @override
  List<Object?> get props => [message];
}
