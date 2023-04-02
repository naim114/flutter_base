import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/role_model.dart';

class UserModel {
  final String id;
  final String email;
  final String? name;
  final DateTime? birthday;
  final String? phone;
  final Country country;
  final String? avatarPath;
  final RoleModel role;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  @protected
  final String password;

  UserModel({
    required this.id,
    this.name,
    this.birthday,
    this.phone,
    this.country = Countries.mys,
    required this.email,
    required this.password,
    this.avatarPath,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Object?> doc)
      : this(
          id: doc.get('id'),
          email: doc.get('email'),
          name: doc.get('name'),
          birthday: doc.get('birthday'),
          phone: doc.get('phone'),
          country: doc.get('country'),
          avatarPath: doc.get('avatarPath'),
          role: doc.get('role'),
          createdAt: DateTime(doc.get('createdAt')),
          updatedAt: DateTime(doc.get('updatedAt')),
          deletedAt: DateTime(doc.get('deletedAt')),
          password: doc.get('password'),
        );

  UserModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot<Object?> doc)
      : this(
          id: doc.get('id'),
          email: doc.get('email'),
          name: doc.get('name'),
          birthday: doc.get('birthday'),
          phone: doc.get('phone'),
          country: doc.get('country'),
          avatarPath: doc.get('avatarPath'),
          role: doc.get('role'),
          createdAt: DateTime(doc.get('createdAt')),
          updatedAt: DateTime(doc.get('updatedAt')),
          deletedAt: DateTime(doc.get('deletedAt')),
          password: doc.get('password'),
        );

  UserModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          email: map['email'],
          name: map['name'],
          birthday: map['birthday'],
          phone: map['phone'],
          country: map['country'],
          avatarPath: map['avatarPath'],
          role: map['role'],
          createdAt: map['createdAt'],
          updatedAt: map['updatedAt'],
          deletedAt: map['deletedAt'],
          password: map['password'],
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'country': country,
      'avatarPath': avatarPath,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'password': password,
    };
  }

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          email: json['email']! as String,
          name: json['name']! as String,
          birthday: json['birthday']! as DateTime,
          phone: json['phone']! as String,
          country: json['country']! as Country,
          avatarPath: json['avatarPath']! as String,
          role: json['role']! as RoleModel,
          createdAt: json['createdAt']! as DateTime,
          updatedAt: json['updatedAt']! as DateTime,
          deletedAt: json['deletedAt']! as DateTime,
          password: json['password']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'country': country.number,
      'avatarPath': avatarPath,
      'role': role.id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'password': password,
    };
  }
}
