part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageErrorState extends HomePageState {
  final String message;
  const HomePageErrorState(this.message);
}

class HomeUserAllLocPageErrorState extends HomePageState {
  final String message;
  const HomeUserAllLocPageErrorState(this.message);
}

class HomeHikeCodeSuccessState extends HomePageState {
  final UserHikeCodeEntity codeEntity;
  const HomeHikeCodeSuccessState(this.codeEntity);
}

class HomeSaveLocationState extends HomePageState {
  final List<UserLocationEntity> userLocationEntity;
  const HomeSaveLocationState(this.userLocationEntity);
}

class HomeSaveAllLocationState extends HomePageState {
  final List<UserLocationEntity> userLocationEntity;
  const HomeSaveAllLocationState(this.userLocationEntity);
}

class HomeLogoutState extends HomePageState {
  final String message;
  const HomeLogoutState(this.message);
}
