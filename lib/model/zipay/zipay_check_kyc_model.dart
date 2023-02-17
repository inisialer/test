
import 'package:json_annotation/json_annotation.dart';

part 'zipay_check_kyc_model.g.dart';

@JsonSerializable()
class ZipayCheckKYCModel {
  Data data;
  String message;
  bool success;

  ZipayCheckKYCModel({this.data, this.message, this.success});

  factory ZipayCheckKYCModel.fromJson(Map<String, dynamic> json) =>
      _$ZipayCheckKYCModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZipayCheckKYCModelToJson(this);
}

@JsonSerializable()
class Data {
  Data(
      {this.result,
      this.message});

  String message;
  int result;

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
