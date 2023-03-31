import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';

class UserActivityModel {
  final UserModel user;
  final String description;
  final String activityType;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  UserActivityModel({
    required this.uid,
    required this.user,
    this.activityType = 'log_in',
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
