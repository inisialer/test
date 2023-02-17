
import 'package:json_annotation/json_annotation.dart';

part 'zipay_history_model.g.dart';

@JsonSerializable()
class ZipayHistoryModel {
  List<Data> data = [];
  String message;
  bool success;

  ZipayHistoryModel({this.data, this.message, this.success});

  factory ZipayHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ZipayHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZipayHistoryModelToJson(this);
}

@JsonSerializable()
class Data {
  Data(
      {this.productName,
      this.refCode,
      this.totalAmount,
      this.status,
      this.transactionDate});

  String refCode;
  String productName;
  String totalAmount;
  String status;
  String transactionDate;

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
