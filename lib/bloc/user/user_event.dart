import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class MeEvent extends UserEvent {
  MeEvent();

  @override
  String toString() => 'MeEvent';
}

class VerifyPinEvent extends UserEvent {
  final String pin;

  VerifyPinEvent({@required this.pin});

  @override
  String toString() => 'VerifyPinEvent';
}

class BalanceEvent extends UserEvent {
  final String state;

  BalanceEvent({@required this.state});

  @override
  String toString() => 'BalanceEvent';
}

class VaZipayEvent extends UserEvent {
  VaZipayEvent();

  @override
  String toString() => 'VaZipayEvent';
}
