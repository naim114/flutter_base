import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/role_model.dart';

class User {
  final String email;
  final String? name;
  final DateTime? birthday;
  final String? phone;
  final Country country;
  final String? avatarPath;
  final Role role;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  @protected
  final String password;

  User({
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
}
