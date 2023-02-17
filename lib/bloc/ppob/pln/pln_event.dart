import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PlnEvent extends Equatable {
  const PlnEvent();

  @override
  List<Object> get props => [];
}

class InquiryPlnPascabayarEvent extends PlnEvent {
  final String noMeter;

  InquiryPlnPascabayarEvent({
    @required this.noMeter,
  });

  @override
  String toString() => 'InquiryPlnPascabayarEvent';
}

class InquiryPlnPrabayarEvent extends PlnEvent {
  final String noMeter;
  final int nominal;

  InquiryPlnPrabayarEvent({
    @required this.noMeter,
    @required this.nominal,
  });

  @override
  String toString() => 'InquiryPlnPrabayarEvent';
}
