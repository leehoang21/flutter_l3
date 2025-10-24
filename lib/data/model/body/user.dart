import 'role.dart';

class User {
  int? id;
  String? username;
  bool? active;
  String? birthPlace;
  String? confirmPassword;
  String? displayName;
  String? dob;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? gender;
  String? university;
  int? year;
  bool? hasPhoto;
  bool? changePass;
  String? tokenDevice;
  List? roles;

  User({
    this.id,
    this.username,
    this.active = true,
    this.birthPlace,
    this.confirmPassword,
    this.displayName,
    this.dob,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.gender,
    this.university,
    this.year,
    this.hasPhoto,
    this.changePass = true,
    this.tokenDevice,
    this.roles,
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
    dob = json['dob'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    roles = rolesList;
    university = json['university'];
    year = json['year'];
    gender = json['gender'];
    hasPhoto = json['hasPhoto'];
    changePass = json['changePass'];
    tokenDevice = json['tokenDevice'];
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'birthPlace': birthPlace,
      'confirmPassword': confirmPassword,
      "displayName": displayName,
      'dob': dob,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'university': university,
      'year': year,
      'gender': gender,
      'changePass': changePass,
      'active': active,
    };
  }
}
