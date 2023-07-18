// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromJson(jsonString);

import 'dart:convert';

ResendOtpModel resendOtpModelFromJson(String str) => ResendOtpModel.fromJson(json.decode(str));

String resendOtpModelToJson(ResendOtpModel data) => json.encode(data.toJson());

class ResendOtpModel {
  bool? success;
  Data? data;

  ResendOtpModel({
    this.success,
    this.data,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  String? success;
  int? status;
  int? otp;

  Data({
    this.success,
    this.status,
    this.otp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    status: json["status"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "otp": otp,
  };
}
