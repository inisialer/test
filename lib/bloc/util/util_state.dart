import 'package:alhikmah_app/model/util/convert_base_64_model.dart';
import 'package:alhikmah_app/model/util/upload_private_model.dart';
import 'package:alhikmah_app/model/util/upload_public_model.dart';
import 'package:equatable/equatable.dart';

abstract class UtilState extends Equatable {
  const UtilState();

  @override
  List<Object> get props => [];
}

class UtilInitial extends UtilState {}

class UploadPrivateSuccessState extends UtilState {
  final UploadPrivateModel data;

  UploadPrivateSuccessState({this.data});
}

class UploadPrivateFailedState extends UtilState {
  final String message;

  UploadPrivateFailedState({this.message});
}

class UploadPublicSuccessState extends UtilState {
  final UploadPublicModel data;

  UploadPublicSuccessState({this.data});
}

class UploadPublicFailedState extends UtilState {
  final String message;

  UploadPublicFailedState({this.message});
}

class UploadConvertSuccessState extends UtilState {
  final ConvertBase64Model data;

  UploadConvertSuccessState({this.data});
}

class UploadConvertFailedState extends UtilState {
  final String message;

  UploadConvertFailedState({this.message});
}

class SetDropdownState extends UtilState {
  final String item;
  final String category;

  SetDropdownState({this.item, this.category});
}