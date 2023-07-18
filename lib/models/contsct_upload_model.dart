// To parse this JSON data, do
//
//     final contactUploadModel = contactUploadModelFromJson(jsonString);

import 'dart:convert';

ContactUploadModel contactUploadModelFromJson(String str) => ContactUploadModel.fromJson(json.decode(str));

String contactUploadModelToJson(ContactUploadModel data) => json.encode(data.toJson());

class ContactUploadModel {
  int? status;
  String? message;

  ContactUploadModel({
    this.status,
    this.message,
  });

  factory ContactUploadModel.fromJson(Map<String, dynamic> json) => ContactUploadModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
