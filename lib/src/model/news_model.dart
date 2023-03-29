import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';

class News {
  final String title;
  final int likeCount;
  final User author;
  final String jsonContent;
  final bool starred;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  News({
    required this.uid,
    required this.title,
    required this.likeCount,
    required this.author,
    required this.jsonContent,
    required this.starred,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
