// To parse this JSON data, do
//
//     final profileFetchModel = profileFetchModelFromJson(jsonString);

import 'dart:convert';

ProfileFetchModel profileFetchModelFromJson(String str) => ProfileFetchModel.fromJson(json.decode(str));

String profileFetchModelToJson(ProfileFetchModel data) => json.encode(data.toJson());

class ProfileFetchModel {
  int? status;
  ProfileData? data;

  ProfileFetchModel({
    this.status,
    this.data,
  });

  factory ProfileFetchModel.fromJson(Map<String, dynamic> json) => ProfileFetchModel(
    status: json["status"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class ProfileData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  dynamic emailVerifiedAt;
  int? account;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileData({
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

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
