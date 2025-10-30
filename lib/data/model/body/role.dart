import 'package:timesheet/utils/enum_role.dart';

class Role {
  int? id;
  String? name;
  EnumRole? authority;

  Role(this.id, this.name, this.authority);
  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    authority = EnumRoleExtension.fromString(json['authority']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'authority': authority?.name,
    };
  }
}
