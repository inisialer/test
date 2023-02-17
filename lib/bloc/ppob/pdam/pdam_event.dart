import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PdamEvent extends Equatable {
  const PdamEvent();

  @override
  List<Object> get props => [];
}

class PdamAreasEvent extends PdamEvent {
  PdamAreasEvent();

  @override
  String toString() => 'PdamAreasEvent';
}

class InquiryPdamEvent extends PdamEvent {
  final String areaId;
  final String customerId;

  InquiryPdamEvent({
    @required this.areaId,
    @required this.customerId,
  });

  @override
  String toString() => 'InquiryPdamEvent';
}
