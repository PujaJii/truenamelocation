// To parse this JSON data, do
//
//     final userUpdatesModel = userUpdatesModelFromJson(jsonString);

import 'dart:convert';

UserUpdatesModel userUpdatesModelFromJson(String str) => UserUpdatesModel.fromJson(json.decode(str));

String userUpdatesModelToJson(UserUpdatesModel data) => json.encode(data.toJson());

class UserUpdatesModel {
  int? status;
  String? message;

  UserUpdatesModel({
    this.status,
    this.message,
  });

  factory UserUpdatesModel.fromJson(Map<String, dynamic> json) => UserUpdatesModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
