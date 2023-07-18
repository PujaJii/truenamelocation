// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  int? status;
  String? message;
  String? profileImage;

  ImageModel({
    this.status,
    this.message,
    this.profileImage,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    status: json["status"],
    message: json["message"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "profile_image": profileImage,
  };
}
