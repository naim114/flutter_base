import 'package:flutter/material.dart';

class Role {
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

  Role({
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
