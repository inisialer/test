// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipay_check_kyc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZipayCheckKYCModel _$ZipayCheckKYCModelFromJson(Map<String, dynamic> json) {
  return ZipayCheckKYCModel(
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ZipayCheckKYCModelToJson(ZipayCheckKYCModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    result: json['result'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
