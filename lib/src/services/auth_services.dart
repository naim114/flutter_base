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
    return _auth.authStateChanges().asyncMap((User? user) {
      return user == null
          ? null
          : UserServices().getUserModelFromFirebase(user);
    });
  }

  //sign up with email & password
  Future signUp({
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

      final activity = await UserServices().get(user.uid).then((user) {
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

      print("Activity: ${activity.toString()}");

      Fluttertoast.showToast(
          msg: "Sign up success! Please log in first before continue.");
      return true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString().contains(
                  'email address is already in use by another account')
              ? "The email address is already in use by another account."
              : e.toString());

      return false;
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
        final activity =
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

        print("Activity: ${activity.toString()}");
      });
    } catch (e) {
      print(e.toString());

      return false;
    }
  }

  //sing out
  Future signOut(UserModel user) async {
    try {
      return await _auth.signOut().then((userCred) async {
        final activity = await UserServices().get(user.id).then((user) {
          if (user != null) {
            return UserActivityServices().add(
              user: user,
              description: "Sign Out",
              activityType: "sign_out",
              networkInfo: _networkInfo,
              deviceInfoPlugin: _deviceInfoPlugin,
            );
          }
        });

        print("Activity: ${activity.toString()}");
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
