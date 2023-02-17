
import 'package:json_annotation/json_annotation.dart';

part 'zipay_update_kyc_model.g.dart';

@JsonSerializable()
class ZipayUpdateKYCModel {
  dynamic data;
  String message;
  bool success;

  ZipayUpdateKYCModel({this.data, this.message, this.success});

  factory ZipayUpdateKYCModel.fromJson(Map<String, dynamic> json) =>
      _$ZipayUpdateKYCModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZipayUpdateKYCModelToJson(this);
}
