// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipay_va_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZipayVAModel _$ZipayVAModelFromJson(Map<String, dynamic> json) {
  return ZipayVAModel(
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ZipayVAModelToJson(ZipayVAModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    bankName: json['bankName'] as String,
    vacctNo: json['vacctNo'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'vacctNo': instance.vacctNo,
      'bankName': instance.bankName,
    };
