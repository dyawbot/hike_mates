part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class GetLoginEvent extends LoginPageEvent {
  final LoginParams? params;

  GetLoginEvent({this.params});
  @override
  List<Object?> get props => [params];
}
