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
    required this.description,
    required this.activityType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  UserActivityModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          user: json['user']! as UserModel,
          description: json['description']! as String,
          activityType: json['activityType']! as String,
          createdAt: json['createdAt']! as DateTime,
          updatedAt: json['updatedAt']! as DateTime,
          deletedAt: json['deletedAt']! as DateTime,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'user': user.id,
      'description': description,
      'activityType': activityType,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
