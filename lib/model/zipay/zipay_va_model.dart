import 'package:json_annotation/json_annotation.dart';

part 'zipay_va_model.g.dart';

@JsonSerializable()
class ZipayVAModel {
  List<Data> data;
  String message;
  bool success;

  ZipayVAModel({this.data, this.message, this.success});

  factory ZipayVAModel.fromJson(Map<String, dynamic> json) =>
      _$ZipayVAModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZipayVAModelToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.bankName,
    this.vacctNo,
  });

  String vacctNo;
  String bankName;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
