import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/role_model.dart';

class User {
  final String name;
  final DateTime birthday;
  final Country country;
  final String? avatarPath;
  final String email;
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
    required this.name,
    required this.birthday,
    required this.country,
    required this.email,
    required this.password,
    this.avatarPath,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
