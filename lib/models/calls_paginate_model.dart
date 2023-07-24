// To parse this JSON data, do
//
//     final callsPaginateModel = callsPaginateModelFromJson(jsonString);

import 'dart:convert';

CallsPaginateModel callsPaginateModelFromJson(String str) => CallsPaginateModel.fromJson(json.decode(str));

String callsPaginateModelToJson(CallsPaginateModel data) => json.encode(data.toJson());

class CallsPaginateModel {
  int? status;
  List<CallLog>? callLogs;

  CallsPaginateModel({
    this.status,
    this.callLogs,
  });

  factory CallsPaginateModel.fromJson(Map<String, dynamic> json) => CallsPaginateModel(
    status: json["status"],
    callLogs: json["call_logs"] == null ? [] : List<CallLog>.from(json["call_logs"]!.map((x) => CallLog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "call_logs": callLogs == null ? [] : List<dynamic>.from(callLogs!.map((x) => x.toJson())),
  };
}

class CallLog {
  int? id;
  int? userId;
  String? callerName;
  String? callFromMobile;
  CallType? callType;
  String? callDuration;
  String? callTime;
  CallerStatus? callerStatus;
  dynamic onCallStatus;

  CallLog({
    this.id,
    this.userId,
    this.callerName,
    this.callFromMobile,
    this.callType,
    this.callDuration,
    this.callTime,
    this.callerStatus,
    this.onCallStatus,
  });

  factory CallLog.fromJson(Map<String, dynamic> json) => CallLog(
    id: json["id"],
    userId: json["user_id"],
    callerName: json["caller_name"],
    callFromMobile: json["call_from_mobile"],
    callType: callTypeValues.map[json["call_type"]]!,
    callDuration: json["call_duration"],
    callTime: json["call_time"],
    callerStatus: callerStatusValues.map[json["caller_status"]]!,
    onCallStatus: json["on_call_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "caller_name": callerName,
    "call_from_mobile": callFromMobile,
    "call_type": callTypeValues.reverse[callType],
    "call_duration": callDuration,
    "call_time": callTime,
    "caller_status": callerStatusValues.reverse[callerStatus],
    "on_call_status": onCallStatus,
  };
}

enum CallType { INCOMING, OUTGOING, BLOCKED, MISSED, REJECTED }

final callTypeValues = EnumValues({
  "blocked": CallType.BLOCKED,
  "incoming": CallType.INCOMING,
  "missed": CallType.MISSED,
  "outgoing": CallType.OUTGOING,
  "rejected": CallType.REJECTED
});

enum CallerStatus { FAIR }

final callerStatusValues = EnumValues({
  "fair": CallerStatus.FAIR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
