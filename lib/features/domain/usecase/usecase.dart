import 'package:equatable/equatable.dart';

abstract class Usecase<Response, Paramaters extends Params> {
  Response call(Paramaters params);
}

abstract class ListUsecase<Response, Paramaters extends Params> {
  Response call(List<Paramaters> params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

// class ListParams extends Params{
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();

// }
