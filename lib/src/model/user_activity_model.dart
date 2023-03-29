import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';

class UserActivity {
  final User user;
  final String description;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  UserActivity({
    required this.uid,
    required this.user,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
