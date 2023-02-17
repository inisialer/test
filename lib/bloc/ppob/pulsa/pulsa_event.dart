import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PulsaEvent extends Equatable {
  const PulsaEvent();

  @override
  List<Object> get props => [];
}

class PhoneProviderEvent extends PulsaEvent {
  final String code;

  PhoneProviderEvent({
    @required this.code,
  });

  @override
  String toString() => 'PhoneProviderEvent';
}

class ItemPulsaPrabayarEvent extends PulsaEvent {
  final String provider;

  ItemPulsaPrabayarEvent({
    @required this.provider,
  });

  @override
  String toString() => 'ItemPulsaEvent';
}

class ItemPaketPrabayarEvent extends PulsaEvent {
  final String provider;

  ItemPaketPrabayarEvent({
    @required this.provider,
  });

  @override
  String toString() => 'ItemPaketEvent';
}

class RecentPulsaPrabayarEvent extends PulsaEvent {
  RecentPulsaPrabayarEvent();

  @override
  String toString() => 'RecentPulsaEvent';
}

class RecentPulsaPrabayarPhoneEvent extends PulsaEvent {
  RecentPulsaPrabayarPhoneEvent();

  @override
  String toString() => 'RecentPulsaPhoneEvent';
}

class RequestPulsaPrabayarEvent extends PulsaEvent {
  final String paymentMethod;
  final String phoneNumber;
  final String productCode;
  final String vaBankCode;

  RequestPulsaPrabayarEvent(
      {@required this.paymentMethod,
      @required this.phoneNumber,
      @required this.productCode,
      @required this.vaBankCode});

  @override
  String toString() => 'RequestPulsaEvent';
}

class InquiryPulsaPascabayarEvent extends PulsaEvent {
  final String phoneNumber;

  InquiryPulsaPascabayarEvent({
    @required this.phoneNumber,
  });

  @override
  String toString() => 'InquiryPulsaPascabayarEvent';
}