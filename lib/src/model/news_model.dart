import 'package:flutter_base/src/model/user_model.dart';

class NewsModel {
  final String id;
  final String title;
  final int likeCount;
  final UserModel? author;
  final UserModel? updatedBy;
  final String jsonContent;
  final bool starred;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;

  NewsModel({
    required this.id,
    required this.title,
    this.likeCount = 0,
    required this.author,
    this.updatedBy,
    required this.jsonContent,
    this.starred = false,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, likeCount: $likeCount, author: $author, updatedBy: $updatedBy, jsonContent: $jsonContent, starred: $starred, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'likeCount': likeCount,
      'author': author,
      'updatedBy': updatedBy,
      'jsonContent': jsonContent,
      'starred': starred,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
