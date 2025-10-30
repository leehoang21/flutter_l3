part of 'post_model.dart';

class MediaModel {
  final int? contentSize;
  final String? contentType;
  final String? extension;
  final String? filePath;
  final int? id;
  final bool? isVideo;
  final String? name;

  MediaModel({
    this.contentSize,
    this.contentType,
    this.extension,
    this.filePath,
    this.id,
    this.isVideo,
    this.name,
  });

  MediaModel copyWith({
    int? contentSize,
    String? contentType,
    String? extension,
    String? filePath,
    int? id,
    bool? isVideo,
    String? name,
  }) =>
      MediaModel(
        contentSize: contentSize ?? this.contentSize,
        contentType: contentType ?? this.contentType,
        extension: extension ?? this.extension,
        filePath: filePath ?? this.filePath,
        id: id ?? this.id,
        isVideo: isVideo ?? this.isVideo,
        name: name ?? this.name,
      );

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        contentSize: json["contentSize"],
        contentType: json["contentType"],
        extension: json["extension"],
        filePath: json["filePath"],
        id: json["id"],
        isVideo: json["isVideo"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "contentSize": contentSize,
        "contentType": contentType,
        "extension": extension,
        "filePath": filePath,
        "id": id,
        "isVideo": isVideo,
        "name": name,
      };
}
