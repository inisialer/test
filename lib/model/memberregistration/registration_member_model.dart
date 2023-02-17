// To parse this JSON data, do
//
//     final registrationMemberModel = registrationMemberModelFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'registration_member_model.g.dart';

RegistrationMemberModel registrationMemberModelFromJson(String str) =>
    RegistrationMemberModel.fromJson(json.decode(str));

String registrationMemberModelToJson(RegistrationMemberModel data) =>
    json.encode(data.toJson());

@JsonSerializable(fieldRename: FieldRename.snake)
class RegistrationMemberModel {
  RegistrationMemberModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory RegistrationMemberModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationMemberModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  Data({

    this.isInitiated,
    this.member,
  });
  @JsonKey(name:"is_initiated")
  bool isInitiated;
  DataMemberRegistration member;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DataMemberRegistration {
  DataMemberRegistration({
    this.accountBankCode,
    this.accountBankName,
    this.accountHolderName,
    this.accountIsChecked,
    this.accountIsVerified,
    this.accountNumber,
    this.accountRealHolderName,
    this.additionalIncome,
    this.additionalIncomeSource,
    this.addressDomicile,
    this.addressKtp,
    this.averageMonthlyProfit,
    this.birthDate,
    this.birthPlace,
    this.businessActivityPhoto,
    this.businessAddress,
    this.businessLicensePhoto,
    this.businessPhone,
    this.businessPlacePhoto,
    this.companyAddress,
    this.companyField,
    this.companyName,
    this.companyPhone,
    this.email,
    this.fullName,
    this.heirName,
    this.heirRelation,
    this.id,
    this.isAccountSubmitted,
    this.isStep1Submitted,
    this.isStep2Submitted,
    this.isStep3Submitted,
    this.job,
    this.jobPosition,
    this.jobType,
    this.ktpPhoto,
    this.ktpValidityPeriod,
    this.lastEducation,
    this.mainIncome,
    this.memberNumber,
    this.mothersName,
    this.nationality,
    this.nik,
    this.npwpPhoto,
    this.numberOfDependents,
    this.placeOwnershipProofPhoto,
    this.registrationStatus,
    this.rejectReason,
    this.selfiePhoto,
    this.signaturePhoto,
    this.statusBusinessLegal,
    this.statusBusinessPlace,
    this.statusResidence,
    this.userId,
    this.whatsappNumber,
    this.workingYear,
    this.gender,
    this.religion,
    this.maritalStatus,
  });

  @JsonKey(name: "marital_status")
  String maritalStatus;
  String gender;
  String religion;
  @JsonKey(name:"account_bank_code")
  String accountBankCode;
  @JsonKey(name: "account_bank_name")
  String accountBankName;
  @JsonKey(name: "account_holder_name")
  String accountHolderName;
  @JsonKey(name: "account_is_checked")
  bool accountIsChecked;
  @JsonKey(name: "account_is_verified")
  bool accountIsVerified;
  @JsonKey(name:"account_number")
  String accountNumber;
  @JsonKey(name: "account_real_holder_name")
  String accountRealHolderName;
  @JsonKey(name: "additional_income")
  String additionalIncome;
  @JsonKey(name: "additional_income_source")
  String additionalIncomeSource;
  @JsonKey(name: "address_domicile")
  String addressDomicile;
  @JsonKey(name: "address_ktp")
  String addressKtp;
  @JsonKey(name:"average_monthly_prfofit")
  String averageMonthlyProfit;
  @JsonKey(name: "birth_date")
  String birthDate;
  @JsonKey(name: "birth_place")
  String birthPlace;
  @JsonKey(name: "business_activity_photo")
  String businessActivityPhoto;
  @JsonKey(name:"business_address")
  String businessAddress;
  String businessLicensePhoto;
  String businessPhone;
  String businessPlacePhoto;
  String companyAddress;
  String companyField;
  String companyName;
  String companyPhone;
  String email;
  String fullName;
  String heirName;
  String heirRelation;
  String id;
  bool isAccountSubmitted;
  bool isStep1Submitted;
  bool isStep2Submitted;
  bool isStep3Submitted;
  String job;
  String jobPosition;
  String jobType;
  String ktpPhoto;
  String ktpValidityPeriod;
  String lastEducation;
  String mainIncome;
  String memberNumber;
  String mothersName;
  String nationality;
  String nik;
  String npwpPhoto;
  int numberOfDependents;
  String placeOwnershipProofPhoto;
  String registrationStatus;
  String rejectReason;
  String selfiePhoto;
  String signaturePhoto;
  String statusBusinessLegal;
  String statusBusinessPlace;
  String statusResidence;
  String userId;
  String whatsappNumber;
  int workingYear;

  factory DataMemberRegistration.fromJson(Map<String, dynamic> json) =>
      _$DataMemberRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$DataMemberRegistrationToJson(this);
}
