// To parse this JSON data, do
//
//     final secondRegistrationEmployeePayloadModel = secondRegistrationEmployeePayloadModelFromJson(jsonString);

import 'dart:convert';

SecondRegistrationEmployeePayloadModel
    secondRegistrationEmployeePayloadModelFromJson(String str) =>
        SecondRegistrationEmployeePayloadModel.fromJson(json.decode(str));

String secondRegistrationEmployeePayloadModelToJson(
        SecondRegistrationEmployeePayloadModel data) =>
    json.encode(data.toJson());

class SecondRegistrationEmployeePayloadModel {
  SecondRegistrationEmployeePayloadModel({
    this.additionalIncome,
    this.additionalIncomeSource,
    this.companyAddress,
    this.companyField,
    this.companyName,
    this.companyPhone,
    this.job,
    this.jobPosition,
    this.mainIncome,
    this.workingYear,
  });

  String additionalIncome;
  String additionalIncomeSource;
  String companyAddress;
  String companyField;
  String companyName;
  String companyPhone;
  String job;
  String jobPosition;
  String mainIncome;
  int workingYear;

  factory SecondRegistrationEmployeePayloadModel.fromJson(
          Map<String, dynamic> json) =>
      SecondRegistrationEmployeePayloadModel(
        additionalIncome: json["additional_income"],
        additionalIncomeSource: json["additional_income_source"],
        companyAddress: json["company_address"],
        companyField: json["company_field"],
        companyName: json["company_name"],
        companyPhone: json["company_phone"],
        job: json["job"],
        jobPosition: json["job_position"],
        mainIncome: json["main_income"],
        workingYear: json["working_year"],
      );

  Map<String, dynamic> toJson() => {
        "additional_income": additionalIncome,
        "additional_income_source": additionalIncomeSource,
        "company_address": companyAddress,
        "company_field": companyField,
        "company_name": companyName,
        "company_phone": companyPhone,
        "job": job,
        "job_position": jobPosition,
        "main_income": mainIncome,
        "working_year": workingYear,
      };
}
