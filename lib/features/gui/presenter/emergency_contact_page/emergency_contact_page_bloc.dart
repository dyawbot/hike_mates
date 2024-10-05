import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hike_mates/common/api_result.dart';

import 'package:hike_mates/features/domain/entity/user_emergency_contact_entity.dart';
import 'package:hike_mates/features/domain/parameters/user_contact_emergency_params.dart';
import 'package:hike_mates/features/domain/usecase/user_emergency_contact_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'emergency_contact_page_event.dart';
part 'emergency_contact_page_state.dart';

@Injectable()
class EmergencyContactPageBloc
    extends Bloc<EmergencyContactPageEvent, EmergencyContactPageState> {
  //  UserEmergencyContactUsecase
  final UserEmergencyContactUsecase _userEmergencyContactUsecase;
  final UpdateUserEmergencyContactUsecase _updateUserEmergencyContactUsecase;
  final DeleteUserEmergencyContactUsecase _deleteUserEmergencyContactUsecase;

  EmergencyContactPageBloc(
    this._userEmergencyContactUsecase,
    this._updateUserEmergencyContactUsecase,
    this._deleteUserEmergencyContactUsecase,
  ) : super(EmergencyContactPageInitial()) {
    on<AddContactInfoEvent>((event, emit) async {
      final logger = Logger();

      logger.d(event.params);
      var result = await _userEmergencyContactUsecase(event.params);

      // logger.d(result);

      var status = result.status;

      if (status == Status.success) {
        logger.d("FUCKING");
        var data = result.data;
        if (data != null) {
          logger.d("HAL KAAAAA");
          logger.d(data);
          emit(AddEmergencyContactPageState(data));
        } else {
          emit(EmergencyContactPageErrorState(result.message!));
        }
      } else {
        emit(EmergencyContactPageErrorState(result.message!));
      }
    });

    on<UpdateContactInfoEvent>((event, emit) async {
      var result = await _updateUserEmergencyContactUsecase(event.params);

      var status = result.status;

      if (status != Status.error) {
        var data = result.data;
        if (data != null) {
          emit(UpdateEmergencyContactPageState(data));
        } else {
          emit(EmergencyContactPageErrorState(result.message!));
        }
      } else {
        emit(EmergencyContactPageErrorState(result.message!));
      }
    });

    on<DeleteContactInfoEvent>((event, emit) async {
      var result = await _deleteUserEmergencyContactUsecase(event.params);

      var status = result.status;

      if (status != Status.error) {
        var data = result.data;
        if (data != null) {
          emit(DeleteEmergencyContactPageState(data));
        } else {
          emit(EmergencyContactPageErrorState(result.message!));
        }
      } else {
        emit(EmergencyContactPageErrorState(result.message!));
      }
    });
  }
}
