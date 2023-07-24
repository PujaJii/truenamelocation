// To parse this JSON data, do
//
//     final profileFetchModel = profileFetchModelFromJson(jsonString);

import 'dart:convert';

ProfileFetchModel profileFetchModelFromJson(String str) => ProfileFetchModel.fromJson(json.decode(str));

String profileFetchModelToJson(ProfileFetchModel data) => json.encode(data.toJson());

class ProfileFetchModel {
  int? status;
  List<ProfileData>? data;

  ProfileFetchModel({
    this.status,
    this.data,
  });

  factory ProfileFetchModel.fromJson(Map<String, dynamic> json) => ProfileFetchModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<ProfileData>.from(json["data"]!.map((x) => ProfileData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProfileData {
  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? photo;
  dynamic birthdate;
  dynamic gender;
  dynamic callerStatus;

  ProfileData({
    this.id,
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.photo,
    this.birthdate,
    this.gender,
    this.callerStatus,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    fullName: json["full_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobile: json["mobile"],
    photo: json["photo"],
    birthdate: json["birthdate"],
    gender: json["gender"],
    callerStatus: json["caller_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
    "photo": photo,
    "birthdate": birthdate,
    "gender": gender,
    "caller_status": callerStatus,
  };
}
