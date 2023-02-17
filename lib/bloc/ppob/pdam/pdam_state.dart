import 'package:alhikmah_app/model/ppob/pdam/inquiry_pdam_model.dart';
import 'package:alhikmah_app/model/ppob/pdam/pdam_areas_model.dart';
import 'package:equatable/equatable.dart';

abstract class PdamState extends Equatable {
  const PdamState();

  @override
  List<Object> get props => [];
}

class PdamInitial extends PdamState {}

class GetPdamAreasSuccessState extends PdamState {
  final PdamAreasModel data;

  GetPdamAreasSuccessState({this.data});
}

class GetPdamAreasFailedState extends PdamState {
  final String message;

  GetPdamAreasFailedState({this.message});
}

class GetInquiryPdamSuccessState extends PdamState {
  final InquiryPdamModel data;

  GetInquiryPdamSuccessState({this.data});
}

class GetInquiryPdamFailedState extends PdamState {
  final String message;

  GetInquiryPdamFailedState({this.message});
}
