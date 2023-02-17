import 'package:equatable/equatable.dart';

abstract class MasterEvent extends Equatable {
  const MasterEvent();

  @override
  List<Object> get props => [];
}

class ResidenceStatusEvent extends MasterEvent {
  ResidenceStatusEvent();

  @override
  String toString() => 'ResidenceStatusEvent';
}

class LastEducationEvent extends MasterEvent {
  LastEducationEvent();

  @override
  String toString() => 'LastEducationEvent';
}

class JobEvent extends MasterEvent {
  JobEvent();

  @override
  String toString() => 'JobEvent';
}

class BusinessPlaceStatusEvent extends MasterEvent {
  BusinessPlaceStatusEvent();

  @override
  String toString() => 'BusinessPlaceStatusEvent';
}

class DisburseBankEvent extends MasterEvent {
  DisburseBankEvent();

  @override
  String toString() => 'DisburseBankEvent';
}
