import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/src/model/user_activity_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';

class UserActivityServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('UserActivity');

  // Add activity
  Future add({
    required UserModel user,
    required String description,
    required String activityType,
  }) async {
    try {
      dynamic add = await _collectionRef.add({
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'deletedAt': null,
      }).then((docRef) {
        _db
            .collection("UserActivity")
            .doc(docRef.id)
            .set(
              UserActivityModel(
                id: docRef.id,
                user: user,
                description: description,
                activityType: activityType,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ).toJson(),
            )
            .then((value) => print("User Activity Setted"))
            .catchError(
                (error) => print("Failed to set user activity: $error"));

        print("User Activity Added");
      }).catchError((error) => print("Failed to add user activity: $error"));

      print(add.toString());

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }
}
