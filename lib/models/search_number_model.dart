// To parse this JSON data, do
//
//     final searchNumberModel = searchNumberModelFromJson(jsonString);

import 'dart:convert';

SearchNumberModel searchNumberModelFromJson(String str) => SearchNumberModel.fromJson(json.decode(str));

String searchNumberModelToJson(SearchNumberModel data) => json.encode(data.toJson());

class SearchNumberModel {
  int? status;
  String? hasContact;
  List<MyContact>? myContact;
  String? hasTrueCaller;
  List<TrueCaller>? trueCaller;
  String? hasAnotherContact;
  String? anotherContact;

  SearchNumberModel({
    this.status,
    this.hasContact,
    this.myContact,
    this.hasTrueCaller,
    this.trueCaller,
    this.hasAnotherContact,
    this.anotherContact,
  });

  factory SearchNumberModel.fromJson(Map<String, dynamic> json) => SearchNumberModel(
    status: json["status"],
    hasContact: json["has_contact"],
    myContact: json["my_contact"] == null ? [] : List<MyContact>.from(json["my_contact"]!.map((x) => MyContact.fromJson(x))),
    hasTrueCaller: json["has_true_caller"],
    trueCaller: json["true_caller"] == null ? [] : List<TrueCaller>.from(json["true_caller"]!.map((x) => TrueCaller.fromJson(x))),
    hasAnotherContact: json["has_another_contact"],
    anotherContact: json["another_contact"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "has_contact": hasContact,
    "my_contact": myContact == null ? [] : List<dynamic>.from(myContact!.map((x) => x.toJson())),
    "has_true_caller": hasTrueCaller,
    "true_caller": trueCaller == null ? [] : List<dynamic>.from(trueCaller!.map((x) => x.toJson())),
    "has_another_contact": hasAnotherContact,
    "another_contact": anotherContact,
  };
}

class MyContact {
  String? name;
  String? mobile;

  MyContact({
    this.name,
    this.mobile,
  });

  factory MyContact.fromJson(Map<String, dynamic> json) => MyContact(
    name: json["name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
  };
}

class TrueCaller {
  String? fullName;
  String? mobile;

  TrueCaller({
    this.fullName,
    this.mobile,
  });

  factory TrueCaller.fromJson(Map<String, dynamic> json) => TrueCaller(
    fullName: json["full_name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "mobile": mobile,
  };
}
