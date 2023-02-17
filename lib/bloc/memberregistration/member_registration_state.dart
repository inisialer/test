import 'package:alhikmah_app/model/memberregistration/registration_member_model.dart';
import 'package:alhikmah_app/model/memberregistration/registration_submit_member_model.dart';
import 'package:alhikmah_app/model/memberregistration/success_registration_member_model.dart';
import 'package:equatable/equatable.dart';

abstract class MemberRegistrationState extends Equatable {
  const MemberRegistrationState();

  @override
  List<Object> get props => [];
}

class MemberRegistrationInitial extends MemberRegistrationState {}

class RegistrationMemberSuccessState extends MemberRegistrationState {
  final RegistrationMemberModel data;

  RegistrationMemberSuccessState({this.data});
}

class RegistrationMemberFailedState extends MemberRegistrationState {
  final String message;

  RegistrationMemberFailedState({this.message});
}

class InitRegistrationMemberSuccessState extends MemberRegistrationState {
  final SuccessRegistrationMemberModel data;
  final String jobType;

  InitRegistrationMemberSuccessState({this.data, this.jobType});
}

class InitRegistrationMemberFailedState extends MemberRegistrationState {
  final String message;

  InitRegistrationMemberFailedState({this.message});
}

class SecondRegistrationEmployeeSuccessState extends MemberRegistrationState {
  final SuccessRegistrationMemberModel data;

  SecondRegistrationEmployeeSuccessState({this.data});
}

class SecondRegistrationEmployeeFailedState extends MemberRegistrationState {
  final String message;

  SecondRegistrationEmployeeFailedState({this.message});
}

class SecondRegistrationBusinessOwnerSuccessState
    extends MemberRegistrationState {
  final SuccessRegistrationMemberModel data;

  SecondRegistrationBusinessOwnerSuccessState({this.data});
}

class SecondRegistrationBusinessOwnerFailedState
    extends MemberRegistrationState {
  final String message;

  SecondRegistrationBusinessOwnerFailedState({this.message});
}

class ThirdRegistrationEmployeeSuccessState extends MemberRegistrationState {
  final SuccessRegistrationMemberModel data;

  ThirdRegistrationEmployeeSuccessState({this.data});
}

class ThirdRegistrationEmployeeFailedState extends MemberRegistrationState {
  final String message;

  ThirdRegistrationEmployeeFailedState({this.message});
}

class ThirdRegistrationBusinessOwnerSuccessState
    extends MemberRegistrationState {
  final SuccessRegistrationMemberModel data;

  ThirdRegistrationBusinessOwnerSuccessState({this.data});
}

class ThirdRegistrationBusinessOwnerFailedState
    extends MemberRegistrationState {
  final String message;

  ThirdRegistrationBusinessOwnerFailedState({this.message});
}

class AccountRegistrationMemberSuccessState extends MemberRegistrationState {
  final SuccessRegistrationMemberModel data;

  AccountRegistrationMemberSuccessState({this.data});
}

class AccountRegistrationMemberFailedState extends MemberRegistrationState {
  final String message;

  AccountRegistrationMemberFailedState({this.message});
}

class SubmitRegistrationMemberSuccessState extends MemberRegistrationState {
  final RegistrationSubmitMemberModel data;

  SubmitRegistrationMemberSuccessState({this.data});
}

class SubmitRegistrationMemberFailedState extends MemberRegistrationState {
  final String message;

  SubmitRegistrationMemberFailedState({this.message});
}
