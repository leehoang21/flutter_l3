import 'user.dart';

class TimesheetModel {
  final DateTime? dateAttendance;
  final int? id;
  final String? ip;
  final String? message;
  final bool? offline;
  final User? user;

  TimesheetModel({
    this.dateAttendance,
    this.id,
    this.ip,
    this.message,
    this.offline,
    this.user,
  });

  TimesheetModel copyWith({
    DateTime? dateAttendance,
    int? id,
    String? ip,
    String? message,
    bool? offline,
    User? user,
  }) =>
      TimesheetModel(
        dateAttendance: dateAttendance ?? this.dateAttendance,
        id: id ?? this.id,
        ip: ip ?? this.ip,
        message: message ?? this.message,
        offline: offline ?? this.offline,
        user: user ?? this.user,
      );

  factory TimesheetModel.fromJson(Map<String, dynamic> json) => TimesheetModel(
        dateAttendance: json["dateAttendance"] == null
            ? null
            : DateTime.parse(json["dateAttendance"]),
        id: json["id"],
        ip: json["ip"],
        message: json["message"],
        offline: json["offline"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "dateAttendance": dateAttendance?.toIso8601String(),
        "id": id,
        "ip": ip,
        "message": message,
        "offline": offline,
        "user": user?.toJson(),
      };
}
