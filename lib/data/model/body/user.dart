import 'dart:ffi';

import 'package:timesheet/data/model/body/role.dart';

class User {
  Long? id;
  String? username;
  bool? active;
  String? birthPlace;
  bool? changePass;
  String? confirmPassword;
  String? displayName;
  String? dob;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  List<Role>? roles;
  String? university;
  int? year;
  String? gender;
  bool? hasPhoto;

  User(
      this.id,
      this.username,
      this.active,
      this.birthPlace,
      this.changePass,
      this.confirmPassword,
      this.displayName,
      this.dob,
      this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.roles,
      this.university,
      this.year,
      this.gender,
      this.hasPhoto);
  User.fromJson(Map<String, dynamic> json) {
    List<dynamic> listRoles = json['roles']??[];
    List<Role> rolesList = listRoles.cast<Role>().toList();
    id = json['id'];
    username = json['username'];
    active = json['active'];
    birthPlace = json['birthPlace'];
    changePass = json['changePass'];
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
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username':username,
      'active':active,
      'birthPlace':birthPlace,
      'changePass':changePass,
      'confirmPassword':confirmPassword,
      "displayName":displayName,
      'dob':dob,
      'email':email,
      'firstName':firstName,
      'lastName':lastName,
      'password':password,
      'roles': roles?.map((roles) => roles.toJson()).toList(),
      'university':university,
      'year':year,
      'gender':gender,
      'hasPhoto':hasPhoto
    };
  }
}
