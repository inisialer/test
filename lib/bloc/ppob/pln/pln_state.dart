import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_pascabayar_model.dart';
import 'package:alhikmah_app/model/ppob/pln/inquiry_pln_prabayar_model.dart';
import 'package:equatable/equatable.dart';

abstract class PlnState extends Equatable {
  const PlnState();

  @override
  List<Object> get props => [];
}

class PlnInitial extends PlnState {}

class GetInquiryPlnPascabayarSuccessState extends PlnState {
  final InquiryPlnPascabayarModel data;

  GetInquiryPlnPascabayarSuccessState({this.data});
}

class GetInquiryPlnPascabayarFailedState extends PlnState {
  final String message;

  GetInquiryPlnPascabayarFailedState({this.message});
}

class GetInquiryPlnPrabayarSuccessState extends PlnState {
  final InquiryPlnPrabayarModel data;

  GetInquiryPlnPrabayarSuccessState({this.data});
}

class GetInquiryPlnPrabayarFailedState extends PlnState {
  final String message;

  GetInquiryPlnPrabayarFailedState({this.message});
}
