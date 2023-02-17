
import 'package:equatable/equatable.dart';

abstract class ZipayEvent extends Equatable {
  const ZipayEvent();

  @override
  List<Object> get props => [];
}


class TransactionHistoryEvent extends ZipayEvent{

  TransactionHistoryEvent();

  @override
  String toString() => 'TransactionHistoryEvent';
}

class TransactionVAEvent extends ZipayEvent{

  TransactionVAEvent();

  @override
  String toString() => 'TransactionVAEvent';
}


class StatusKYCEvent extends ZipayEvent{

  StatusKYCEvent();

  @override
  String toString() => 'StatusKycEvent';
}


class UpdateKYCEvent extends ZipayEvent{

  final String idCard;
  final String selfie;

  UpdateKYCEvent({this.idCard, this.selfie});

  @override
  String toString() => 'UpdateKycEvent';
}