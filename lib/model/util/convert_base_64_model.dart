
import 'package:json_annotation/json_annotation.dart';

part 'convert_base_64_model.g.dart';

@JsonSerializable()
class ConvertBase64Model {
  Data data;
  String message;
  bool success;

  ConvertBase64Model({this.data, this.message, this.success});

  factory ConvertBase64Model.fromJson(Map<String, dynamic> json) =>
      _$ConvertBase64ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConvertBase64ModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  Data(
      {this.base64WithoutType,
        this.base64String});

  String base64String;
  String base64WithoutType;

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
