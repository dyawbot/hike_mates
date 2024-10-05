part of 'emergency_contact_page_bloc.dart';

abstract class EmergencyContactPageEvent extends Equatable {
  const EmergencyContactPageEvent();

  @override
  List<Object> get props => [];
}

class AddContactInfoEvent extends EmergencyContactPageEvent {
  final UserContactEmergencyParams? params;
  const AddContactInfoEvent({this.params});
}

class UpdateContactInfoEvent extends EmergencyContactPageEvent {
  final UserContactEmergencyParams params;
  const UpdateContactInfoEvent(this.params);
}

class DeleteContactInfoEvent extends EmergencyContactPageEvent {
  final DeleteNumberParams params;
  const DeleteContactInfoEvent(this.params);
}
