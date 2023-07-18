// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  int? status;
  String? message;
  String? token;
  UserData? userData;

  VerifyOtpModel({
    this.status,
    this.message,
    this.token,
    this.userData,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    userData: json["userData"] == null ? null : UserData.fromJson(json["userData"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "userData": userData?.toJson(),
  };
}

class UserData {
  int? id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  String? mobile;
  dynamic emailVerifiedAt;
  int? account;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.account,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobile: json["mobile"],
    emailVerifiedAt: json["email_verified_at"],
    account: json["account"],
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
    "account": account,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
