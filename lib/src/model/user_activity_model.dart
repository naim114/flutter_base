import 'package:flutter_base/src/model/user_model.dart';

class UserActivityModel {
  final String id;
  final UserModel user;
  final String description;
  final String activityType;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  UserActivityModel({
    required this.id,
    required this.user,
    this.activityType = 'log_in',
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
