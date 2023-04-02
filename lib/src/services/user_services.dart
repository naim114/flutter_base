import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/src/model/user_model.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('User');

  Future<List<UserModel>> getAll() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List of Role Model
    final List<UserModel> allData = querySnapshot.docs
        .map((doc) => UserModel.fromQueryDocumentSnapshot(doc))
        .toList();

    return allData;
  }

  Future<UserModel?> get(String id) async {
    return _collectionRef
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel.fromDocumentSnapshot(documentSnapshot);
      } else {
        print('Document does not exist on the database');
        return null;
      }
    });
  }

  Future<List<UserModel>> getBy(String fieldName, String value) async {
    List<UserModel> dataList = List.empty(growable: true);

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List<QueryDocumentSnapshot<Object?>> allDoc =
        querySnapshot.docs.toList();

    for (var doc in allDoc) {
      if (doc.get(fieldName) == value) {
        dataList.add(UserModel.fromDocumentSnapshot(doc));
      }
    }

    return dataList;
  }

  //create an userModel object based on Firebase User object
  Future<UserModel?> getUserModelFromFirebase(User? user) async {
    if (user != null) {
      String email = user.email.toString();

      final users = await UserServices().getBy('email', email);
      return users.first;
    } else {
      return null;
    }
  }
}
