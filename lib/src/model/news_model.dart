import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';

class NewsModel {
  final String title;
  final int likeCount;
  final UserModel author;
  final String jsonContent;
  final bool starred;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String uid;

  NewsModel({
    required this.uid,
    required this.title,
    this.likeCount = 0,
    required this.author,
    required this.jsonContent,
    this.starred = false,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
