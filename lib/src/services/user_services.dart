import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country/country.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:flutter_base/src/services/role_services.dart';
import 'package:flutter_base/src/services/user_activity_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_info_plus/network_info_plus.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('User');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final NetworkInfo _networkInfo = NetworkInfo();

  // get all users
  Future<List<Future<UserModel?>>> getAll() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List of Role Model
    final allData = querySnapshot.docs
        .map((doc) => UserServices().fromQueryDocumentSnapshot(doc))
        .toList();

    return allData;
  }

  // get user by id
  Future<UserModel?> get(String id) {
    return _collectionRef.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        return UserServices().fromDocumentSnapshot(doc);
      } else {
        print('Document does not exist on the database');
        return null;
      }
    });
  }

  // get user by custom field
  Future<List<UserModel?>> getBy(String fieldName, String value) async {
    List<UserModel?> dataList = List.empty(growable: true);

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List<QueryDocumentSnapshot<Object?>> allDoc =
        querySnapshot.docs.toList();

    for (var doc in allDoc) {
      if (doc.get(fieldName) == value) {
        UserModel? user = await UserServices().fromDocumentSnapshot(doc);

        if (user != null) {
          dataList.add(user);
        }
      }
    }

    return dataList;
  }

  // create an userModel object based on Firebase User object
  Future<UserModel?> getUserModelFromFirebase(User? user) async {
    if (user != null) {
      String email = user.email.toString();

      final users = await UserServices().getBy('email', email);

      return users.first;
    } else {
      return null;
    }
  }

  // convert DocumentSnapshot to userModel object
  Future<UserModel?> fromDocumentSnapshot(DocumentSnapshot<Object?> doc) async {
    return UserModel(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      birthday: doc.get('birthday') == null
          ? doc.get('birthday')
          : doc.get('birthday').toDate(),
      phone: doc.get('phone'),
      address: doc.get('address'),
      country: Countries.values
          .firstWhere((country) => country.number == doc.get('country')),
      avatarPath: doc.get('avatarPath'),
      role: await RoleServices().get(doc.get('role')),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
      deletedAt: doc.get('deletedAt') == null
          ? doc.get('deletedAt')
          : doc.get('deletedAt').toDate(),
      password: doc.get('password'),
    );
  }

  // convert QueryDocumentSnapshot to userModel object
  Future<UserModel?> fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Object?> doc) async {
    return UserModel(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      birthday: doc.get('birthday') == null
          ? doc.get('birthday')
          : doc.get('birthday').toDate(),
      phone: doc.get('phone'),
      address: doc.get('address'),
      country: Countries.values
          .firstWhere((country) => country.number == doc.get('country')),
      avatarPath: doc.get('avatarPath'),
      role: await RoleServices().get(doc.get('role')),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
      deletedAt: doc.get('deletedAt') == null
          ? doc.get('deletedAt')
          : doc.get('deletedAt').toDate(),
      password: doc.get('password'),
    );
  }

  // Update user details (name, birthday, phone, address, country)
  Future updateDetails({
    required UserModel user,
    required String? name,
    required DateTime? birthday,
    required String? phone,
    required String? address,
    required String countryNumber,
  }) async {
    try {
      dynamic result = _collectionRef.doc(user.id).update({
        'name': name,
        'birthday': birthday,
        'phone': phone,
        'address': address,
        'country': countryNumber,
        'updatedAt': DateTime.now(),
      }).then((value) => print("User Updated"));

      print(result.toString());

      final activity = await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          await UserActivityServices()
              .add(
                user: currentUser,
                description:
                    "Update Profile Details. Target: ${user.email} (ID: ${user.id})",
                activityType: "user_update_detail",
                networkInfo: _networkInfo,
                deviceInfoPlugin: _deviceInfoPlugin,
              )
              .then((value) => print("Activity Added"));
        }
      });

      print("Activity: ${activity.toString()}");

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }

  // Updae user email
  Future updateEmail({
    required UserModel user,
    required String? oldEmail,
    required String newEmail,
    required String? password,
    required bool includeAuth,
  }) async {
    try {
      if (includeAuth && password != null) {
        // w/ auth

        // encrypt entered password
        var bytes = utf8.encode(password);
        var digest = sha1.convert(bytes);

        // ignore: invalid_use_of_protected_member
        if (oldEmail == user.email) {
          await _auth
              .signInWithEmailAndPassword(
            email: user.email,
            password: digest.toString(),
          )
              .then((userCred) {
            print("Log In Success");
            if (userCred.user != null) {
              // update user cred at auth
              userCred.user
                  ?.updateEmail(newEmail)
                  .then((value) => print("Email Updated on Auth"));

              // update user on db
              _collectionRef.doc(userCred.user?.uid).update({
                'email': newEmail,
              }).then((value) => print("Email Updated on Firestore"));
            }
          });
        } else {
          throw Exception("Could not authorize credentials.");
        }
      } else {
        // w/o auth
        // TODO test this code
        User? userCred = await FirebaseAuth.instance
            .userChanges()
            .firstWhere((userCred) => userCred?.uid == user.id);

        if (userCred != null) {
          // update user cred at auth
          userCred
              .updateEmail(newEmail)
              .then((value) => print("Email Updated on Auth"));

          // update user on db
          _collectionRef.doc(userCred.uid).update({
            'email': newEmail,
          }).then((value) => print("Email Updated on Firestore"));
        }
      }

      final activity = await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          await UserActivityServices()
              .add(
                user: currentUser,
                description:
                    "Update Profile Email. Target: ${user.email} (ID: ${user.id})",
                activityType: "user_update_email",
                networkInfo: _networkInfo,
                deviceInfoPlugin: _deviceInfoPlugin,
              )
              .then((value) => print("Activity Added"));
        }
      });

      print("Activity: ${activity.toString()}");

      return true;
    } catch (e) {
      print(e.toString());

      if (e.toString().contains('[firebase_auth/email-already-in-use]')) {
        Fluttertoast.showToast(
            msg: "Email already taken. Please try different email.");
      } else {
        Fluttertoast.showToast(msg: e.toString());
      }

      return false;
    }
  }
}
