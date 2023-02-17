// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipay_update_kyc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZipayUpdateKYCModel _$ZipayUpdateKYCModelFromJson(Map<String, dynamic> json) {
  return ZipayUpdateKYCModel(
    data: json['data'],
    message: json['message'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ZipayUpdateKYCModelToJson(
        ZipayUpdateKYCModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };
