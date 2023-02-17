import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BpjsEvent extends Equatable {
  const BpjsEvent();

  @override
  List<Object> get props => [];
}

class InquiryBpjsEvent extends BpjsEvent {
  final String familyVaNumber;
  final String payUntil;

  InquiryBpjsEvent({
    @required this.familyVaNumber,
    @required this.payUntil,
  });

  @override
  String toString() => 'InquiryBpjsEvent';
}
