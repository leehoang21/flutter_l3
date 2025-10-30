import 'user.dart';

class NotificationModel {
  final String? body;
  final DateTime? date;
  final int? id;
  final String? title;
  final String? type;
  final User? user;

  NotificationModel({
    this.body,
    this.date,
    this.id,
    this.title,
    this.type,
    this.user,
  });

  NotificationModel copyWith({
    String? body,
    DateTime? date,
    int? id,
    String? title,
    String? type,
    User? user,
  }) =>
      NotificationModel(
        body: body ?? this.body,
        date: date ?? this.date,
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        user: user ?? this.user,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        body: json["body"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["id"],
        title: json["title"],
        type: json["type"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "date": date?.toIso8601String(),
        "id": id,
        "title": title,
        "type": type,
        "user": user?.toJson(),
      };
}
