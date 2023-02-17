// To parse this JSON data, do
//
//     final initRegistrationPayloadModel = initRegistrationPayloadModelFromJson(jsonString);

import 'dart:convert';

InitRegistrationMemberPayloadModel initRegistrationPayloadModelFromJson(
        String str) =>
    InitRegistrationMemberPayloadModel.fromJson(json.decode(str));

String initRegistrationMemberPayloadModelToJson(
        InitRegistrationMemberPayloadModel data) =>
    json.encode(data.toJson());

class InitRegistrationMemberPayloadModel {
  InitRegistrationMemberPayloadModel({
    this.addressDomicile,
    this.addressKtp,
    this.birthDate,
    this.birthPlace,
    this.email,
    this.fullName,
    this.heirName,
    this.heirRelation,
    this.jobType,
    this.lastEducation,
    this.mothersName,
    this.nik,
    this.numberOfDependents,
    this.statusResidence,
    this.whatsappNumber,
    this.gender,
    this.maritalStatus,
    this.religion,
  });

  String gender;
  String maritalStatus;
  String religion;
  String addressDomicile;
  String addressKtp;
  String birthDate;
  String birthPlace;
  String email;
  String fullName;
  String heirName;
  String heirRelation;
  String jobType;
  String lastEducation;
  String mothersName;
  String nik;
  int numberOfDependents;
  String statusResidence;
  String whatsappNumber;

  factory InitRegistrationMemberPayloadModel.fromJson(
          Map<String, dynamic> json) =>
      InitRegistrationMemberPayloadModel(
        maritalStatus: json["marital_status"],
        gender: json["gender"],
        religion: json["religion"],
        addressDomicile: json["address_domicile"],
        addressKtp: json["address_ktp"],
        birthDate: json["birth_date"],
        birthPlace: json["birth_place"],
        email: json["email"],
        fullName: json["full_name"],
        heirName: json["heir_name"],
        heirRelation: json["heir_relation"],
        jobType: json["job_type"],
        lastEducation: json["last_education"],
        mothersName: json["mothers_name"],
        nik: json["nik"],
        numberOfDependents: json["number_of_dependents"],
        statusResidence: json["status_residence"],
        whatsappNumber: json["whatsapp_number"],
      );

  Map<String, dynamic> toJson() => {
        "address_domicile": addressDomicile,
        "address_ktp": addressKtp,
        "birth_date": birthDate,
        "birth_place": birthPlace,
        "email": email,
        "full_name": fullName,
        "heir_name": heirName,
        "heir_relation": heirRelation,
        "job_type": jobType,
        "last_education": lastEducation,
        "mothers_name": mothersName,
        "nik": nik,
        "number_of_dependents": numberOfDependents,
        "status_residence": statusResidence,
        "whatsapp_number": whatsappNumber,
        "religion": religion,
        "marital_status": maritalStatus,
        "gender": gender,
      };
}
