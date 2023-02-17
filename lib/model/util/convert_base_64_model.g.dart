// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_base_64_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertBase64Model _$ConvertBase64ModelFromJson(Map<String, dynamic> json) {
  return ConvertBase64Model(
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ConvertBase64ModelToJson(ConvertBase64Model instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    base64WithoutType: json['base_64_without_type'] as String,
    base64String: json['base_64_string'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'base_64_string': instance.base64String,
      'base_64_without_type': instance.base64WithoutType,
    };
