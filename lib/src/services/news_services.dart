import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/src/model/news_model.dart';
import 'package:flutter_base/src/services/user_activity_services.dart';
import 'package:flutter_base/src/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../model/user_model.dart';

class NewsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Notification');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final NetworkInfo _networkInfo = NetworkInfo();

  // convert DocumentSnapshot to model object
  Future<NewsModel?> fromDocumentSnapshot(DocumentSnapshot<Object?> doc) async {
    return NewsModel(
      id: doc.get('id'),
      title: doc.get('title'),
      likeCount: doc.get('likeCount'),
      author: await UserServices().get(doc.get('author')),
      updatedBy: doc.get('updatedBy') == null
          ? doc.get('updatedBy')
          : await UserServices().get(doc.get('author')),
      jsonContent: doc.get('jsonContent'),
      starred: doc.get('starred'),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
    );
  }

  // convert QueryDocumentSnapshot to model object
  Future<NewsModel?> fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Object?> doc) async {
    return NewsModel(
      id: doc.get('id'),
      title: doc.get('title'),
      likeCount: doc.get('likeCount'),
      author: await UserServices().get(doc.get('author')),
      updatedBy: doc.get('updatedBy') == null
          ? doc.get('updatedBy')
          : await UserServices().get(doc.get('author')),
      jsonContent: doc.get('jsonContent'),
      starred: doc.get('starred'),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
    );
  }

  // get all
  Future<List<NewsModel?>> getAll() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> docList = querySnapshot.docs;

      List<Future<NewsModel?>> futures = docList
          .map((doc) => NewsService().fromDocumentSnapshot(doc))
          .toList();

      return await Future.wait(futures);
    } else {
      return List.empty();
    }
  }

  // get by id
  Future<NewsModel?> get(String id) {
    return _collectionRef.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        return NewsService().fromDocumentSnapshot(doc);
      } else {
        print('Document does not exist on the database');
        return null;
      }
    });
  }

  // get by custom field
  Future<List<NewsModel?>> getBy(String fieldName, String value) async {
    List<NewsModel?> dataList = List.empty(growable: true);

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List<QueryDocumentSnapshot<Object?>> allDoc =
        querySnapshot.docs.toList();

    for (var doc in allDoc) {
      if (doc.get(fieldName) == value) {
        NewsModel? noti = await NewsService().fromDocumentSnapshot(doc);

        if (noti != null) {
          dataList.add(noti);
        }
      }
    }

    return dataList;
  }

  Future add({
    required String title,
    required String jsonContent,
    required UserModel author,
  }) async {
    // TODO test this
    try {
      dynamic add = await _collectionRef.add({
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'deletedAt': null,
      }).then((docRef) {
        _collectionRef
            .doc(docRef.id)
            .set(NewsModel(
              id: docRef.id,
              title: title,
              author: author,
              jsonContent: jsonContent,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ).toJson())
            .then((value) => print("News Added"));
      });

      print("Add News: $add");

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          UserModel? user = await UserServices().get(currentUser.id);

          if (user != null) {
            await UserActivityServices()
                .add(
                  user: currentUser,
                  description: "Post News (Title: $title)",
                  activityType: "news_add",
                  networkInfo: _networkInfo,
                  deviceInfoPlugin: _deviceInfoPlugin,
                )
                .then((value) => print("Activity Added"));
            return true;
          }
        }
      });

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future edit({
    required NewsModel news,
    required String title,
    required String jsonContent,
    required UserModel author,
  }) async {
    // TODO test this
    try {
      dynamic result = _collectionRef.doc(news.id).update({
        'title': title,
        'jsonContent': jsonContent,
        'updatedAt': DateTime.now(),
      }).then((value) => print("Notification Read"));

      print("Update News: $result");

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          UserModel? user = await UserServices().get(currentUser.id);

          if (user != null) {
            await UserActivityServices()
                .add(
                  user: currentUser,
                  description: "Edit News (Title: $title)",
                  activityType: "news_edit",
                  networkInfo: _networkInfo,
                  deviceInfoPlugin: _deviceInfoPlugin,
                )
                .then((value) => print("Activity Added"));
            return true;
          }
        }
      });

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future delete({
    required NewsModel notification,
  }) async {
    // TODO test this
    try {
      final delete = _collectionRef.doc(notification.id).delete();

      print("Delete Notification: $delete");

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          await UserActivityServices()
              .add(
                user: currentUser,
                description: "Delete News (Title: ${notification.title})",
                activityType: "news_delete",
                networkInfo: _networkInfo,
                deviceInfoPlugin: _deviceInfoPlugin,
              )
              .then((value) => print("Activity Added"));
        }
      });

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }
}
