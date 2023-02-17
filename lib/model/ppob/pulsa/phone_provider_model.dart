// To parse this JSON data, do
//
//     final pulsaProviderModel = pulsaProviderModelFromJson(jsonString);

import 'dart:convert';

PhoneProviderModel phoneProviderModelFromJson(String str) =>
    PhoneProviderModel.fromJson(json.decode(str));

String phoneProviderModelToJson(PhoneProviderModel data) =>
    json.encode(data.toJson());

class PhoneProviderModel {
  PhoneProviderModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory PhoneProviderModel.fromJson(Map<String, dynamic> json) =>
      PhoneProviderModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.provider,
  });

  Provider provider;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        provider: Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
      };
}

class Provider {
  Provider({
    this.provider,
    this.picture,
  });

  String provider;
  String picture;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        provider: json["provider"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "picture": picture,
      };
}
