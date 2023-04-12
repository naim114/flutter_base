import 'package:flutter_base/src/model/user_model.dart';

class NewsModel {
  final String id;
  final String title;
  final int likeCount;
  final UserModel? author;
  final UserModel? updatedBy;
  final String jsonContent;
  final bool starred;
  final String? imgPath;
  final String? imgURL;

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
    this.imgPath,
    this.imgURL,
  });

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, likeCount: $likeCount, author: $author, updatedBy: $updatedBy, jsonContent: $jsonContent, starred: $starred, createdAt: $createdAt, updatedAt: $updatedAt, imgPath: $imgPath, imgURL: $imgURL)';
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'likeCount': likeCount,
      'author': author!.id,
      'updatedBy': updatedBy == null ? null : updatedBy!.id,
      'jsonContent': jsonContent,
      'starred': starred,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'imgPath': imgPath,
      'imgURL': imgURL,
    };
  }
}
