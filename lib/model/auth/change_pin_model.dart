
import 'dart:convert';

ChangePinModel loginModelFromJson(String str) =>
    ChangePinModel.fromJson(json.decode(str));

String loginModelToJson(ChangePinModel data) => json.encode(data.toJson());

class ChangePinModel {
  ChangePinModel({
    this.data,
    this.message,
    this.success,
  });

  Data data;
  String message;
  bool success;

  factory ChangePinModel.fromJson(Map<String, dynamic> json) => ChangePinModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "success": success,
  };
}

class Data {
  Data({
    this.accessToken,
    this.expiresAt,
    this.refreshToken,
  });

  String accessToken;
  int expiresAt;
  String refreshToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    expiresAt: json["expires_at"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_at": expiresAt,
    "refresh_token": refreshToken,
  };
}
