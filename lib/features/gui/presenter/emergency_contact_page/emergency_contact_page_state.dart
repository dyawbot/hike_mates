part of 'emergency_contact_page_bloc.dart';

sealed class EmergencyContactPageState extends Equatable {
  const EmergencyContactPageState();

  @override
  List<Object> get props => [];
}

class EmergencyContactPageInitial extends EmergencyContactPageState {}

class UpdateEmergencyContactPageState extends EmergencyContactPageState {
  final UserEmergencyContactEntity updatedData;
  const UpdateEmergencyContactPageState(this.updatedData);
}

class AddEmergencyContactPageState extends EmergencyContactPageState {
  final List<UserEmergencyContactEntity> updatedData;
  const AddEmergencyContactPageState(this.updatedData);
}

class DeleteEmergencyContactPageState extends EmergencyContactPageState {
  final List<UserEmergencyContactEntity> updatedData;
  const DeleteEmergencyContactPageState(this.updatedData);
}

class EmergencyContactPageErrorState extends EmergencyContactPageState {
  final String message;
  const EmergencyContactPageErrorState(this.message);
}
