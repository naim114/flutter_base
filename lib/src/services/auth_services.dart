import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:flutter_base/src/services/role_services.dart';
import 'package:flutter_base/src/services/user_activity_services.dart';
import 'package:flutter_base/src/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_info_plus/network_info_plus.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final NetworkInfo _networkInfo = NetworkInfo();

  // auth change user stream
  Stream<UserModel?> get onAuthStateChanged {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) {
        return null;
      } else {
        try {
          final authStateChanges = _auth.authStateChanges();
          print("authStateChanges: ${authStateChanges.toString()}");

          final tokenChanges = _auth.idTokenChanges();
          print("tokenChanges: ${tokenChanges.toString()}");

          return await UserServices().getUserModelFromFirebase(user);
        } catch (e) {
          print(e.toString());
          return null;
        }
      }
    });
  }

  // sign up with email & password
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Encrypt password
      var bytes = utf8.encode(password);
      var digest = sha1.convert(bytes);

      // Create user credential
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: digest.toString(),
      );

      // Get result
      User user = result.user!;

      // Initialize role
      final userRole = await RoleServices().getBy('name', 'user');

      // Add to firestore
      if (userRole.isNotEmpty) {
        await _db.collection("User").doc(user.uid).set(
              UserModel(
                name: name,
                createdAt: DateTime.now(),
                email: email,
                password: digest.toString(),
                role: userRole.first,
                id: user.uid,
                updatedAt: DateTime.now(),
              ).toJson(),
            );
      }

      await UserServices().get(user.uid).then((user) {
        if (user != null) {
          return UserActivityServices().add(
            user: user,
            description: "Sign Up/Create Account",
            activityType: "sign_up",
            networkInfo: _networkInfo,
            deviceInfoPlugin: _deviceInfoPlugin,
          );
        }
      });

      Fluttertoast.showToast(msg: "Sign up success!");

      final addedUser = await UserServices().get(user.uid);

      print("Added: $addedUser");

      if (addedUser != null) {
        return addedUser;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString().contains(
                  'email address is already in use by another account')
              ? "The email address is already in use by another account."
              : e.toString());

      return null;
    }
  }

  // sign in with email and password
  Future signIn(
    String email,
    String password,
  ) async {
    try {
      // Encrypt password
      var bytes = utf8.encode(password);
      var digest = sha1.convert(bytes);

      return await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: digest.toString(),
      )
          .then((userCred) async {
        await UserServices().get(userCred.user!.uid).then((user) {
          if (user != null) {
            return UserActivityServices().add(
              user: user,
              description: "Sign In",
              activityType: "sign_in",
              networkInfo: _networkInfo,
              deviceInfoPlugin: _deviceInfoPlugin,
            );
          }
        });
      });
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }

  //sign out
  Future signOut(UserModel user) async {
    try {
      await UserServices().get(user.id).then(
        (user) {
          if (user != null) {
            return UserActivityServices()
                .add(
                  user: user,
                  description: "Sign Out",
                  activityType: "sign_out",
                  networkInfo: _networkInfo,
                  deviceInfoPlugin: _deviceInfoPlugin,
                )
                .then((value) => print("Signed Out"));
          }
        },
      );

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
