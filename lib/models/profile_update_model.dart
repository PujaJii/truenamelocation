// To parse this JSON data, do
//
//     final profileUpdateModel = profileUpdateModelFromJson(jsonString);

import 'dart:convert';

ProfileUpdateModel profileUpdateModelFromJson(String str) => ProfileUpdateModel.fromJson(json.decode(str));

String profileUpdateModelToJson(ProfileUpdateModel data) => json.encode(data.toJson());

class ProfileUpdateModel {
  int? status;
  String? message;

  ProfileUpdateModel({
    this.status,
    this.message,
  });

  factory ProfileUpdateModel.fromJson(Map<String, dynamic> json) => ProfileUpdateModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
