import 'package:flutter/material.dart';

class RoleModel {
  final String name;
  final String displayName;
  final String description;
  final bool removeable;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  RoleModel({
    required this.uid,
    required this.name,
    required this.displayName,
    required this.description,
    this.removeable = true,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
