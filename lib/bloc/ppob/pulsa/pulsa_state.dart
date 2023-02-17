import 'package:alhikmah_app/model/ppob/pulsa/inquiry_pulsa_pascabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_paket_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/item_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/phone_provider_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/recent_pulsa_prabayar_phone_model.dart';
import 'package:alhikmah_app/model/ppob/pulsa/request_pulsa_prabayar_model.dart';
import 'package:equatable/equatable.dart';

abstract class PulsaState extends Equatable {
  const PulsaState();

  @override
  List<Object> get props => [];
}

class PulsaInitial extends PulsaState {}

class GetPhoneProviderSuccessState extends PulsaState {
  final PhoneProviderModel data;

  GetPhoneProviderSuccessState({this.data});
}

class GetPhoneProviderFailedState extends PulsaState {
  final String message;

  GetPhoneProviderFailedState({this.message});
}

class GetItemPulsaPrabayarSuccessState extends PulsaState {
  final ItemPulsaPrabayarModel data;

  GetItemPulsaPrabayarSuccessState({this.data});
}

class GetItemPulsaPrabayarFailedState extends PulsaState {
  final String message;

  GetItemPulsaPrabayarFailedState({this.message});
}

class GetItemPaketPrabayarSuccessState extends PulsaState {
  final ItemPaketPrabayarModel data;

  GetItemPaketPrabayarSuccessState({this.data});
}

class GetItemPaketPrabayarFailedState extends PulsaState {
  final String message;

  GetItemPaketPrabayarFailedState({this.message});
}

class GetRecentPulsaPrabayarSuccessState extends PulsaState {
  final RecentPulsaPrabayarModel data;

  GetRecentPulsaPrabayarSuccessState({this.data});
}

class GetRecentPulsaPrabayarFailedState extends PulsaState {
  final String message;

  GetRecentPulsaPrabayarFailedState({this.message});
}

class GetRecentPulsaPrabayarPhoneSuccessState extends PulsaState {
  final RecentPulsaPrabayarPhoneModel data;

  GetRecentPulsaPrabayarPhoneSuccessState({this.data});
}

class GetRecentPulsaPrabayarPhoneFailedState extends PulsaState {
  final String message;

  GetRecentPulsaPrabayarPhoneFailedState({this.message});
}

class RequestPulsaPrabayarSuccessState extends PulsaState {
  final RequestPulsaPrabayarModel data;

  RequestPulsaPrabayarSuccessState({this.data});
}

class RequestPulsaPrabayarFailedState extends PulsaState {
  final String message;

  RequestPulsaPrabayarFailedState({this.message});
}

class GetInquiryPulsaPascabayarSuccessState extends PulsaState {
  final InquiryPulsaPascabayarModel data;

  GetInquiryPulsaPascabayarSuccessState({this.data});
}

class GetInquiryPulsaPascabayarFailedState extends PulsaState {
  final String message;

  GetInquiryPulsaPascabayarFailedState({this.message});
}
