import 'app_entity.dart';

class UserLocationEntity extends AppEntity {
  final String? lati;
  final String? longi;
  final int? userId;
  final String? hikeCode;
  final String? dateCreated;
  final String? name;

  UserLocationEntity({
    this.lati,
    this.longi,
    this.userId,
    this.hikeCode,
    this.dateCreated,
    this.name,
  });
  // UserLocationEntity({this.lati, this.longi, this.userId, this.dateCreated});

  @override
  List<Object?> get props => [lati, longi, userId, hikeCode, dateCreated, name];
}
