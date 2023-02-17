import 'package:alhikmah_app/model/memberregistration/registration_status_model.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationStatusState extends Equatable {
  const RegistrationStatusState();

  @override
  List<Object> get props => [];
}

class RegistrationStatusInitial extends RegistrationStatusState {}

class RegistrationStatusLoaded extends RegistrationStatusState {
  final RegistrationStatusModel registrationStatusModel;

  RegistrationStatusLoaded({this.registrationStatusModel});

  @override
  List<Object> get props => [registrationStatusModel];
}

class RegistrationStatusError extends RegistrationStatusState {
  final String error;

  RegistrationStatusError({this.error});

  @override
  List<Object> get props => [error];
}
