import 'item_content.dart';

class Data {
  List<ItemContent>? content;

  Data(this.content);

  Data.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['content'] ?? [];
    content = [];
    for (var item in list) {
      if (item is Map<String, dynamic>) {
        content!.add(ItemContent.fromJson(item));
      }
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'content':content
    };
  }
}
