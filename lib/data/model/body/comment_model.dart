part of 'post_model.dart';

class CommentModel {
  final String? content;
  final DateTime? date;
  final int? id;
  final User? user;
  final int? type;
  final PostModel? post;

  CommentModel({
    this.content,
    this.date,
    this.id,
    this.user,
    this.type,
    this.post,
  });

  CommentModel copyWith({
    String? content,
    DateTime? date,
    int? id,
    User? user,
    int? type,
    PostModel? post,
  }) =>
      CommentModel(
        content: content ?? this.content,
        date: date ?? this.date,
        id: id ?? this.id,
        user: user ?? this.user,
        type: type ?? this.type,
        post: post ?? this.post,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        content: json["content"],
        date: json["date"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json["date"]),
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "date": date?.toIso8601String(),
        "id": id,
        "user": user?.toJson(),
        "type": type,
        "post": post?.toJson(),
      };
}
