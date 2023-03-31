import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/role_model.dart';

class UserModel {
  final String email;
  final String? name;
  final DateTime? birthday;
  final String? phone;
  final Country country;
  final String? avatarPath;
  final RoleModel role;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  @protected
  final String password;

  UserModel({
    required this.uid,
    this.name,
    this.birthday,
    this.phone,
    this.country = Countries.mys,
    required this.email,
    required this.password,
    this.avatarPath,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          email: json['email']! as String,
          name: json['name']! as String,
          birthday: json['birthday']! as DateTime,
          phone: json['phone']! as String,
          country: json['country']! as Country,
          avatarPath: json['avatarPath']! as String,
          role: json['role']! as RoleModel,
          createdAt: json['createdAt']! as DateTime,
          updatedAt: json['updatedAt']! as DateTime,
          deletedAt: json['deletedAt']! as DateTime,
          password: json['password']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'country': country,
      'avatarPath': avatarPath,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'password': password,
    };
  }
}
