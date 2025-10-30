import '../data/model/body/role.dart';

enum EnumRole {
  admin,
  user,
}

extension EnumRoleExtension on EnumRole {
  String get name {
    switch (this) {
      case EnumRole.admin:
        return 'ROLE_ADMIN';
      case EnumRole.user:
        return 'ROLE_USER';
    }
  }

  Role get value {
    switch (this) {
      case EnumRole.admin:
        return Role(null, 'ROLE_ADMIN', EnumRole.admin);
      case EnumRole.user:
        return Role(4, 'ROLE_USER', EnumRole.user);
    }
  }

  static EnumRole fromString(String roleString) {
    switch (roleString) {
      case 'ROLE_ADMIN':
        return EnumRole.admin;
      case 'ROLE_USER':
        return EnumRole.user;
      default:
        return EnumRole.user;
    }
  }
}
