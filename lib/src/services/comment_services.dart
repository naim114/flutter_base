import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:news_app/src/model/comment_model.dart';
import 'package:news_app/src/model/news_model.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/services/user_activity_services.dart';
import 'package:news_app/src/services/user_services.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../widgets/list_tile/list_tile_comment.dart';
import 'helpers.dart';

class CommentServices {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Comment');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final NetworkInfo _networkInfo = NetworkInfo();

  // convert DocumentSnapshot to model object
  Future<CommentModel?> fromDocumentSnapshot(
      DocumentSnapshot<Object?> doc) async {
    return CommentModel(
      id: doc.get('id'),
      news: await NewsService().get(doc.get('news')),
      text: doc.get('text'),
      author: await UserServices().get(doc.get('author')),
      createdAt: doc.get('createdAt').toDate(),
    );
  }

  // convert QueryDocumentSnapshot to model object
  Future<CommentModel?> fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Object?> doc) async {
    return CommentModel(
      id: doc.get('id'),
      news: await NewsService().get(doc.get('news')),
      text: doc.get('text'),
      author: await UserServices().get(doc.get('author')),
      createdAt: doc.get('createdAt').toDate(),
    );
  }

  // get all
  Future<List<CommentModel?>> getAll() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _collectionRef.orderBy('createdAt', descending: true).get();

    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> docList = querySnapshot.docs;

      List<Future<CommentModel?>> futures = docList
          .map((doc) => CommentServices().fromDocumentSnapshot(doc))
          .toList();

      return await Future.wait(futures);
    } else {
      return List.empty();
    }
  }

  // get by custom field
  Future<List<CommentModel?>> getByNews(NewsModel news) async {
    List<CommentModel?> dataList = List.empty(growable: true);

    List<CommentModel?> all = await CommentServices().getAll();

    for (var comment in all) {
      if (comment != null &&
          comment.news != null &&
          comment.news!.id == news.id) {
        dataList.add(comment);
      }
    }

    return dataList;
  }

  // add
  Future add({
    required String text,
    required UserModel author,
    required NewsModel news,
  }) async {
    try {
      dynamic add = await _collectionRef.add({
        'createdAt': DateTime.now(),
      }).then((docRef) async {
        _collectionRef
            .doc(docRef.id)
            .set(CommentModel(
              id: docRef.id,
              news: news,
              text: text,
              author: author,
              createdAt: DateTime.now(),
            ).toJson())
            .then((value) => print("Comment Added"));
      });

      print("Add Comment: $add");

      // activity log
      await UserActivityServices()
          .add(
            user: author,
            description:
                "Post comment (Text: $text) on News (ID: ${news.id}, Title: ${news.title})",
            activityType: "comment_add",
            networkInfo: _networkInfo,
            deviceInfoPlugin: _deviceInfoPlugin,
          )
          .then((value) => print("Activity Added"));

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future delete({
    required CommentModel comment,
  }) async {
    try {
      final delete = _collectionRef.doc(comment.id).delete();

      print("Delete News: $delete");

      // activity log
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
                  description:
                      "Delete comment (Text: ${comment.text}) on News (ID: ${comment.news!.id}, Title: ${comment.news!.title})",
                  activityType: "comment_delete",
                  networkInfo: _networkInfo,
                  deviceInfoPlugin: _deviceInfoPlugin,
                )
                .then((value) => print("Activity Added"));
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

  void showComment(
    BuildContext context,
    NewsModel news,
    UserModel currentUser,
  ) {
    final commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.95,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isDarkTheme(context)
                ? CupertinoColors.darkBackgroundGray
                : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //  Header
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: 40,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: const SizedBox(
                    height: 5,
                  ),
                ),
              ),
              Text(
                "Comments",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getColorByBackground(context),
                  fontSize: 16,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              //  Comments Section
              FutureBuilder<List<CommentModel?>?>(
                  future: CommentServices().getByNews(news),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Expanded(
                        child: Center(
                            child: Text(
                          "Error loading comments. Please try again",
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        )),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    }

                    return snapshot.data == null ||
                            (snapshot.data != null && snapshot.data!.isEmpty)
                        ? const Expanded(
                            child: Center(
                                child: Text(
                              "Nothing to find here. Be the first to comment :)",
                              style:
                                  TextStyle(color: CupertinoColors.systemGrey),
                            )),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                  snapshot.data!.length,
                                  (index) {
                                    CommentModel comment =
                                        snapshot.data![index]!;

                                    return listTileComment(
                                      context: context,
                                      comment: comment,
                                      currentUser: currentUser,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                  }),
              // Input
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: isDarkTheme(context)
                        ? CupertinoColors.darkBackgroundGray
                        : Colors.white,
                    hintText: 'Enter comment here',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        if (commentController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please enter comment before send");
                        } else {
                          Fluttertoast.showToast(msg: "Sending comment");

                          dynamic add = await CommentServices().add(
                              text: commentController.text,
                              author: currentUser,
                              news: news);

                          if (add == true && context.mounted) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: "Comment sent");
                            print("Comment sent");
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
