import 'package:hike_mates/features/domain/usecase/usecase.dart';

class UserContactEmergencyParams extends Params {
  final int userId;
  final String contactName;
  final String phoneNumber;
  final String imageFileName;

  UserContactEmergencyParams(
    this.userId,
    this.contactName,
    this.phoneNumber,
    this.imageFileName,
  );
  @override
  List<Object?> get props => [userId, contactName, phoneNumber, imageFileName];
}

class DeleteNumberParams extends Params {
  final String index;

  DeleteNumberParams(this.index);
  @override
  List<Object?> get props => [index];
}
