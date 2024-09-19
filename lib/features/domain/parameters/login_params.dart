import 'package:hike_mates/features/domain/usecase/usecase.dart';

class LoginParams extends Params {
  final String username;
  final String password;

  LoginParams(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}
