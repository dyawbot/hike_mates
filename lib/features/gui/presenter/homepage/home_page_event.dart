part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class SaveHikeCodeEvent extends HomePageEvent {
  final HikeCodeParams? params;

  const SaveHikeCodeEvent({this.params});
}

class SaveUserLocationEvent extends HomePageEvent {
  final UserLocationParams params;
  const SaveUserLocationEvent(this.params);
}

class CheckUserLocationEvent extends HomePageEvent {
  final CheckHikeUserParams params;
  const CheckUserLocationEvent(this.params);
}

class LogoutEvent extends HomePageEvent {}
