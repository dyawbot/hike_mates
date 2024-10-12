import 'package:hike_mates/features/domain/usecase/usecase.dart';

class UserLocationParams extends Params {
  final String lati;
  final String longi;
  final int? userId;
  final String? name;
  final String hikeCode;
  final String? batteryStatus;

  UserLocationParams(
      {required this.lati,
      required this.longi,
      this.userId,
      this.name,
      this.batteryStatus,
      required this.hikeCode});

  @override
  List<Object?> get props => [
        lati,
        longi,
        userId,
        hikeCode,
        name,
        batteryStatus,
      ];
}

class CheckHikeUserParams extends Params {
  final int userId;
  final String? hikeCode;

  CheckHikeUserParams(this.userId, {this.hikeCode});

  @override
  List<Object?> get props => [
        userId,
        hikeCode,
      ];
}
