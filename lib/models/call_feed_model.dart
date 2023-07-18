// To parse this JSON data, do
//
//     final callLogModel = callLogModelFromJson(jsonString);

import 'dart:convert';

CallLogModel callLogModelFromJson(String str) => CallLogModel.fromJson(json.decode(str));

String callLogModelToJson(CallLogModel data) => json.encode(data.toJson());

class CallLogModel {
  int? status;
  String? message;

  CallLogModel({
    this.status,
    this.message,
  });

  factory CallLogModel.fromJson(Map<String, dynamic> json) => CallLogModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
