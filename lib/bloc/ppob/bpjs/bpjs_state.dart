import 'package:alhikmah_app/model/ppob/bpjs/inquiry_bpjs_model.dart';
import 'package:equatable/equatable.dart';

abstract class BpjsState extends Equatable {
  const BpjsState();

  @override
  List<Object> get props => [];
}

class BpjsInitial extends BpjsState {}

class GetInquiryBpjsSuccessState extends BpjsState {
  final InquiryBpjsModel data;

  GetInquiryBpjsSuccessState({this.data});
}

class GetInquiryBpjsFailedState extends BpjsState {
  final String message;

  GetInquiryBpjsFailedState({this.message});
}
