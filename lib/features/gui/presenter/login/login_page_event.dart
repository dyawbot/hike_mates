part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class GetLoginEvent extends LoginPageEvent {
  final LoginParams? params;

  const GetLoginEvent({this.params});
  @override
  List<Object?> get props => [params];
}

class SaveHikeCodeEvent extends LoginPageEvent {
  final HikeCodeParams? params;

  const SaveHikeCodeEvent({this.params});

  @override
  List<Object?> get props => [params];
}
