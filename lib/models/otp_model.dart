// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  int? status;
  String? message;
  int? otp;
  List<OTPData>? userData;

  OtpModel({
    this.status,
    this.message,
    this.otp,
    this.userData,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    status: json["status"],
    message: json["message"],
    otp: json["otp"],
    userData: json["userData"] == null ? [] : List<OTPData>.from(json["userData"]!.map((x) => OTPData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "otp": otp,
    "userData": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
  };
}

class OTPData {
  int? id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  String? mobile;
  dynamic emailVerifiedAt;
  dynamic password;
  int? account;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  OTPData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.password,
    this.account,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  factory OTPData.fromJson(Map<String, dynamic> json) => OTPData(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobile: json["mobile"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    account: json["account"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "account": account,
    "remember_token": rememberToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
