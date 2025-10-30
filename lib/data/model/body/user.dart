import 'role.dart';

class User {
  int? id;
  String? username;
  bool? active;
  String? birthPlace;
  String? confirmPassword;
  String? displayName;
  DateTime? dob;
  String? email;
  String? password;
  String? gender;
  String? university;
  int? year;
  bool? hasPhoto;
  bool? changePass;
  String? tokenDevice;
  List<Role>? roles;
  String? image;

  User({
    this.id,
    this.username,
    this.active = true,
    this.birthPlace,
    this.confirmPassword,
    this.displayName,
    this.dob,
    this.email,
    this.password,
    this.gender,
    this.university,
    this.year,
    this.hasPhoto,
    this.changePass = true,
    this.tokenDevice,
    this.roles,
    this.image,
  });
  User.fromJson(Map<String, dynamic> json) {
    List<dynamic> listRoles = json['roles'] ?? [];
    List<Role> rolesList = listRoles.map((e) => Role.fromJson(e)).toList();
    id = json['id'];
    username = json['username'];
    active = json['active'];
    birthPlace = json['birthPlace'];
    confirmPassword = json['confirmPassword'];
    displayName = json['displayName'];
    dob = json["dob"] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(json["date"]);
    email = json['email'];

    password = json['password'];
    roles = rolesList;
    university = json['university'];
    year = json['year'];
    gender = json['gender'];
    hasPhoto = json['hasPhoto'];
    changePass = json['changePass'];
    tokenDevice = json['tokenDevice'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'birthPlace': birthPlace,
      'confirmPassword': confirmPassword,
      "displayName": displayName,
      'dob': dob?.toIso8601String(),
      'email': email,
      'password': password,
      'university': university,
      'year': year,
      'gender': gender,
      'changePass': changePass,
      'active': active,
    };
  }

  User copyWith({
    bool? active,
    String? birthPlace,
    bool? changePass,
    String? confirmPassword,
    String? displayName,
    DateTime? dob,
    String? email,
    String? gender,
    bool? hasPhoto,
    int? id,
    String? image,
    String? password,
    List<Role>? roles,
    String? tokenDevice,
    String? university,
    String? username,
    int? year,
  }) =>
      User(
        active: active ?? this.active,
        birthPlace: birthPlace ?? this.birthPlace,
        changePass: changePass ?? this.changePass,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        displayName: displayName ?? this.displayName,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        hasPhoto: hasPhoto ?? this.hasPhoto,
        id: id ?? this.id,
        image: image ?? this.image,
        password: password ?? this.password,
        roles: roles ?? this.roles,
        tokenDevice: tokenDevice ?? this.tokenDevice,
        university: university ?? this.university,
        username: username ?? this.username,
        year: year ?? this.year,
      );
}
