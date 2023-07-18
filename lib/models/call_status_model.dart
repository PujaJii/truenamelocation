// To parse this JSON data, do
//
//     final callStatusUpdateModel = callStatusUpdateModelFromJson(jsonString);

import 'dart:convert';

CallStatusUpdateModel callStatusUpdateModelFromJson(String str) => CallStatusUpdateModel.fromJson(json.decode(str));

String callStatusUpdateModelToJson(CallStatusUpdateModel data) => json.encode(data.toJson());

class CallStatusUpdateModel {
  int? status;
  String? message;

  CallStatusUpdateModel({
    this.status,
    this.message,
  });

  factory CallStatusUpdateModel.fromJson(Map<String, dynamic> json) => CallStatusUpdateModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
