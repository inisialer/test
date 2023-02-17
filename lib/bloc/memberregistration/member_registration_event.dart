import 'package:alhikmah_app/screen/main/menu/profile/registration/model/init_registration_member_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/second_registration_business_owner_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/second_registration_employee_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/third_registration_business_owner_payload_model.dart';
import 'package:alhikmah_app/screen/main/menu/profile/registration/model/third_registration_employee_payload_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MemberRegistrationEvent extends Equatable {
  const MemberRegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationMemberEvent extends MemberRegistrationEvent {
  RegistrationMemberEvent();

  @override
  String toString() => 'RegistrationMemberEvent';
}

class InitRegistrationMemberEvent extends MemberRegistrationEvent {
  final InitRegistrationMemberPayloadModel payload;

  InitRegistrationMemberEvent({@required this.payload});

  @override
  String toString() => 'InitRegistrationMemberEvent';
}

class SecondRegistrationEmployeeEvent extends MemberRegistrationEvent {
  final SecondRegistrationEmployeePayloadModel payload;

  SecondRegistrationEmployeeEvent({@required this.payload});

  @override
  String toString() => 'SecondRegistrationEmployeeEvent';
}

class SecondRegistrationBusinessOwnerEvent extends MemberRegistrationEvent {
  final SecondRegistrationBusinessOwnerPayloadModel payload;

  SecondRegistrationBusinessOwnerEvent({@required this.payload});

  @override
  String toString() => 'SecondRegistrationBusinessOwnerEvent';
}

class ThirdRegistrationEmployeeEvent extends MemberRegistrationEvent {
  final ThirdRegistrationEmployeePayloadModel payload;

  ThirdRegistrationEmployeeEvent({@required this.payload});

  @override
  String toString() => 'ThirdRegistrationEmployeeEvent';
}

class ThirdRegistrationBusinessOwnerEvent extends MemberRegistrationEvent {
  final ThirdRegistrationBusinessOwnerPayloadModel payload;

  ThirdRegistrationBusinessOwnerEvent({@required this.payload});

  @override
  String toString() => 'ThirdRegistrationBusinessOwnerEvent';
}

class AccountRegistrationMemberEvent extends MemberRegistrationEvent {
  final String accountBankCode;
  final String accountHolderName;
  final String accountNumber;

  AccountRegistrationMemberEvent({
    @required this.accountBankCode,
    @required this.accountHolderName,
    @required this.accountNumber,
  });

  @override
  String toString() => 'AccountRegistrationMemberEvent';
}

class SubmitRegistrationMemberEvent extends MemberRegistrationEvent {
  SubmitRegistrationMemberEvent();

  @override
  String toString() => 'SubmitRegistrationMemberEvent';
}
