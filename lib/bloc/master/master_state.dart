import 'package:alhikmah_app/model/memberregistration/master/item_business_place_status_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_disburse_bank_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_job_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_last_education_model.dart';
import 'package:alhikmah_app/model/memberregistration/master/item_residence_status_model.dart';
import 'package:equatable/equatable.dart';

abstract class MasterState extends Equatable {
  const MasterState();

  @override
  List<Object> get props => [];
}

class MasterInitial extends MasterState {}

class GetLastEducationSuccessState extends MasterState {
  final ItemLastEducationModel data;

  GetLastEducationSuccessState({this.data});
}

class GetLastEducationFailedState extends MasterState {
  final String message;

  GetLastEducationFailedState({this.message});
}

class GetResidenceStatusSuccessState extends MasterState {
  final ItemResidenceStatusModel data;

  GetResidenceStatusSuccessState({this.data});
}

class GetResidenceStatusFailedState extends MasterState {
  final String message;

  GetResidenceStatusFailedState({this.message});
}

class GetJobSuccessState extends MasterState {
  final ItemJobModel data;

  GetJobSuccessState({this.data});
}

class GetJobFailedState extends MasterState {
  final String message;

  GetJobFailedState({this.message});
}

class GetBusinessPlaceStatusSuccessState extends MasterState {
  final ItemBusinessPlaceStatusModel data;

  GetBusinessPlaceStatusSuccessState({this.data});
}

class GetBusinessPlaceStatusFailedState extends MasterState {
  final String message;

  GetBusinessPlaceStatusFailedState({this.message});
}

class GetDisburseBankSuccessState extends MasterState {
  final ItemDisburseBankModel data;

  GetDisburseBankSuccessState({this.data});
}

class GetDisburseBankFailedState extends MasterState {
  final String message;

  GetDisburseBankFailedState({this.message});
}
