import 'user.dart';

part 'comment_model.dart';
part 'media_model.dart';

class PostModel {
  final List<CommentModel>? comments;
  final String? content;
  final DateTime? date;
  final int? id;
  final List<CommentModel>? likes;
  final List<MediaModel>? media;
  final User? user;

  PostModel({
    this.comments,
    this.content,
    this.date,
    this.id,
    this.likes,
    this.media,
    this.user,
  });

  PostModel copyWith({
    List<CommentModel>? comments,
    String? content,
    DateTime? date,
    int? id,
    List<CommentModel>? likes,
    List<MediaModel>? media,
    User? user,
  }) =>
      PostModel(
        comments: comments ?? this.comments,
        content: content ?? this.content,
        date: date ?? this.date,
        id: id ?? this.id,
        likes: likes ?? this.likes,
        media: media ?? this.media,
        user: user ?? this.user,
      );

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        comments: json["comments"] == null
            ? []
            : List<CommentModel>.from(
                json["comments"]!.map((x) => CommentModel.fromJson(x))),
        content: json["content"],
        date: json["date"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json["date"]),
        id: json["id"],
        likes: json["likes"] == null
            ? []
            : List<CommentModel>.from(
                json["likes"]!.map((x) => CommentModel.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<MediaModel>.from(
                json["media"]!.map((x) => MediaModel.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "content": content,
        "date": date?.toIso8601String(),
        "id": id,
        "likes": likes == null
            ? []
            : List<dynamic>.from(likes!.map((x) => x.toJson())),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "user": user?.toJson(),
      };
}
