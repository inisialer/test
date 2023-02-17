// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationMemberModel _$RegistrationMemberModelFromJson(
    Map<String, dynamic> json) {
  return RegistrationMemberModel(
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
    success: json['success'] as bool,
  );
}

Map<String, dynamic> _$RegistrationMemberModelToJson(
        RegistrationMemberModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    isInitiated: json['is_initiated'] as bool,
    member: json['member'] == null
        ? null
        : DataMemberRegistration.fromJson(
            json['member'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'is_initiated': instance.isInitiated,
      'member': instance.member,
    };

DataMemberRegistration _$DataMemberRegistrationFromJson(
    Map<String, dynamic> json) {
  return DataMemberRegistration(
    accountBankCode: json['account_bank_code'] as String,
    accountBankName: json['account_bank_name'] as String,
    accountHolderName: json['account_holder_name'] as String,
    accountIsChecked: json['account_is_checked'] as bool,
    accountIsVerified: json['account_is_verified'] as bool,
    accountNumber: json['account_number'] as String,
    accountRealHolderName: json['account_real_holder_name'] as String,
    additionalIncome: json['additional_income'] as String,
    additionalIncomeSource: json['additional_income_source'] as String,
    addressDomicile: json['address_domicile'] as String,
    addressKtp: json['address_ktp'] as String,
    averageMonthlyProfit: json['average_monthly_prfofit'] as String,
    birthDate: json['birth_date'] as String,
    birthPlace: json['birth_place'] as String,
    businessActivityPhoto: json['business_activity_photo'] as String,
    businessAddress: json['business_address'] as String,
    businessLicensePhoto: json['business_license_photo'] as String,
    businessPhone: json['business_phone'] as String,
    businessPlacePhoto: json['business_place_photo'] as String,
    companyAddress: json['company_address'] as String,
    companyField: json['company_field'] as String,
    companyName: json['company_name'] as String,
    companyPhone: json['company_phone'] as String,
    email: json['email'] as String,
    fullName: json['full_name'] as String,
    heirName: json['heir_name'] as String,
    heirRelation: json['heir_relation'] as String,
    id: json['id'] as String,
    isAccountSubmitted: json['is_account_submitted'] as bool,
    isStep1Submitted: json['is_step1_submitted'] as bool,
    isStep2Submitted: json['is_step2_submitted'] as bool,
    isStep3Submitted: json['is_step3_submitted'] as bool,
    job: json['job'] as String,
    jobPosition: json['job_position'] as String,
    jobType: json['job_type'] as String,
    ktpPhoto: json['ktp_photo'] as String,
    ktpValidityPeriod: json['ktp_validity_period'] as String,
    lastEducation: json['last_education'] as String,
    mainIncome: json['main_income'] as String,
    memberNumber: json['member_number'] as String,
    mothersName: json['mothers_name'] as String,
    nationality: json['nationality'] as String,
    nik: json['nik'] as String,
    npwpPhoto: json['npwp_photo'] as String,
    numberOfDependents: json['number_of_dependents'] as int,
    placeOwnershipProofPhoto: json['place_ownership_proof_photo'] as String,
    registrationStatus: json['registration_status'] as String,
    rejectReason: json['reject_reason'] as String,
    selfiePhoto: json['selfie_photo'] as String,
    signaturePhoto: json['signature_photo'] as String,
    statusBusinessLegal: json['status_business_legal'] as String,
    statusBusinessPlace: json['status_business_place'] as String,
    statusResidence: json['status_residence'] as String,
    userId: json['user_id'] as String,
    whatsappNumber: json['whatsapp_number'] as String,
    workingYear: json['working_year'] as int,
    gender: json['gender'] as String,
    religion: json['religion'] as String,
    maritalStatus: json['marital_status'] as String,
  );
}

Map<String, dynamic> _$DataMemberRegistrationToJson(
        DataMemberRegistration instance) =>
    <String, dynamic>{
      'marital_status': instance.maritalStatus,
      'gender': instance.gender,
      'religion': instance.religion,
      'account_bank_code': instance.accountBankCode,
      'account_bank_name': instance.accountBankName,
      'account_holder_name': instance.accountHolderName,
      'account_is_checked': instance.accountIsChecked,
      'account_is_verified': instance.accountIsVerified,
      'account_number': instance.accountNumber,
      'account_real_holder_name': instance.accountRealHolderName,
      'additional_income': instance.additionalIncome,
      'additional_income_source': instance.additionalIncomeSource,
      'address_domicile': instance.addressDomicile,
      'address_ktp': instance.addressKtp,
      'average_monthly_prfofit': instance.averageMonthlyProfit,
      'birth_date': instance.birthDate,
      'birth_place': instance.birthPlace,
      'business_activity_photo': instance.businessActivityPhoto,
      'business_address': instance.businessAddress,
      'business_license_photo': instance.businessLicensePhoto,
      'business_phone': instance.businessPhone,
      'business_place_photo': instance.businessPlacePhoto,
      'company_address': instance.companyAddress,
      'company_field': instance.companyField,
      'company_name': instance.companyName,
      'company_phone': instance.companyPhone,
      'email': instance.email,
      'full_name': instance.fullName,
      'heir_name': instance.heirName,
      'heir_relation': instance.heirRelation,
      'id': instance.id,
      'is_account_submitted': instance.isAccountSubmitted,
      'is_step1_submitted': instance.isStep1Submitted,
      'is_step2_submitted': instance.isStep2Submitted,
      'is_step3_submitted': instance.isStep3Submitted,
      'job': instance.job,
      'job_position': instance.jobPosition,
      'job_type': instance.jobType,
      'ktp_photo': instance.ktpPhoto,
      'ktp_validity_period': instance.ktpValidityPeriod,
      'last_education': instance.lastEducation,
      'main_income': instance.mainIncome,
      'member_number': instance.memberNumber,
      'mothers_name': instance.mothersName,
      'nationality': instance.nationality,
      'nik': instance.nik,
      'npwp_photo': instance.npwpPhoto,
      'number_of_dependents': instance.numberOfDependents,
      'place_ownership_proof_photo': instance.placeOwnershipProofPhoto,
      'registration_status': instance.registrationStatus,
      'reject_reason': instance.rejectReason,
      'selfie_photo': instance.selfiePhoto,
      'signature_photo': instance.signaturePhoto,
      'status_business_legal': instance.statusBusinessLegal,
      'status_business_place': instance.statusBusinessPlace,
      'status_residence': instance.statusResidence,
      'user_id': instance.userId,
      'whatsapp_number': instance.whatsappNumber,
      'working_year': instance.workingYear,
    };
