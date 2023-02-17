// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipay_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZipayHistoryModel _$ZipayHistoryModelFromJson(Map<String, dynamic> json) {
  return ZipayHistoryModel(
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$ZipayHistoryModelToJson(ZipayHistoryModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    productName: json['productName'] as String,
    refCode: json['refCode'] as String,
    totalAmount: json['totalAmount'] as String,
    status: json['status'] as String,
    transactionDate: json['transactionDate'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'refCode': instance.refCode,
      'productName': instance.productName,
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'transactionDate': instance.transactionDate,
    };
