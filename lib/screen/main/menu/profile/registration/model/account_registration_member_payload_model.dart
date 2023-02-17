// To parse this JSON data, do
//
//     final accountRegistrationMemberPayloadModel = accountRegistrationMemberPayloadModelFromJson(jsonString);

import 'dart:convert';

AccountRegistrationMemberPayloadModel
    accountRegistrationMemberPayloadModelFromJson(String str) =>
        AccountRegistrationMemberPayloadModel.fromJson(json.decode(str));

String accountRegistrationMemberPayloadModelToJson(
        AccountRegistrationMemberPayloadModel data) =>
    json.encode(data.toJson());

class AccountRegistrationMemberPayloadModel {
  AccountRegistrationMemberPayloadModel({
    this.accountBankCode,
    this.accountBankName,
    this.accountHolderName,
    this.accountNumber,
  });

  String accountBankCode;
  String accountBankName;
  String accountHolderName;
  String accountNumber;

  factory AccountRegistrationMemberPayloadModel.fromJson(
          Map<String, dynamic> json) =>
      AccountRegistrationMemberPayloadModel(
        accountBankCode: json["account_bank_code"],
        accountBankName: json["account_bank_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
      );

  Map<String, dynamic> toJson() => {
        "account_bank_code": accountBankCode,
        "account_bank_name": accountBankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
      };
}
