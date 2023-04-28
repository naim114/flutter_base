import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/model/role_model.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime? birthday;
  final String? phone;
  final String? address;
  final Country country;
  final String? avatarPath;
  final String? avatarURL;
  final RoleModel? role;

  // date
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? disableAt;

  @protected
  final String password;

  UserModel({
    required this.id,
    required this.name,
    this.birthday,
    this.phone,
    this.address,
    this.country = Countries.mys,
    required this.email,
    required this.password,
    this.avatarPath,
    this.avatarURL,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.disableAt,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, birthday: $birthday, phone: $phone, address: $address, country: ${country.isoShortName}, avatarPath: $avatarPath, avatarURL: $avatarURL, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, disableAt: $disableAt, password: $password)';
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          email: map['email'],
          name: map['name'],
          birthday: map['birthday'],
          phone: map['phone'],
          address: map['address'],
          country: map['country'],
          avatarPath: map['avatarPath'],
          avatarURL: map['avatarURL'],
          role: map['role'],
          createdAt: map['createdAt'],
          updatedAt: map['updatedAt'],
          disableAt: map['disableAt'],
          password: map['password'],
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'address': address,
      'country': country,
      'avatarPath': avatarPath,
      'avatarURL': avatarURL,
      'role': role?.id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'disableAt': disableAt,
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
          address: json['address']! as String,
          country: json['country']! as Country,
          avatarPath: json['avatarPath']! as String,
          avatarURL: json['avatarURL']! as String,
          role: json['role']! as RoleModel,
          createdAt: json['createdAt']! as DateTime,
          updatedAt: json['updatedAt']! as DateTime,
          disableAt: json['disableAt']! as DateTime,
          password: json['password']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'address': address,
      'country': country.number,
      'avatarPath': avatarPath,
      'avatarURL': avatarURL,
      'role': role?.id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'disableAt': disableAt,
      'password': password,
    };
  }
}
