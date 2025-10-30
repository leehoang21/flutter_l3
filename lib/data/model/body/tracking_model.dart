import 'user.dart';

class TrackingModel {
  final String? content;
  final DateTime? date;
  final int? id;
  final User? user;

  TrackingModel({
    this.content,
    this.date,
    this.id,
    this.user,
  });

  TrackingModel copyWith({
    String? content,
    DateTime? date,
    int? id,
    User? user,
  }) =>
      TrackingModel(
        content: content ?? this.content,
        date: date ?? this.date,
        id: id ?? this.id,
        user: user ?? this.user,
      );

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      content: json["content"],
      date: json["date"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json["date"]),
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "date": date?.toIso8601String(),
        "id": id,
        "user": user?.toJson(),
      };
}
