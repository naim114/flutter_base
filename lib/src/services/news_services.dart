import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:news_app/src/model/news_model.dart';
import 'package:news_app/src/services/user_activity_services.dart';
import 'package:news_app/src/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('News');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

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
      imgPath: doc.get('imgPath'),
      imgURL: doc.get('imgURL'),
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
      imgPath: doc.get('imgPath'),
      imgURL: doc.get('imgURL'),
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

  // get all
  Future<List<NewsModel?>> getAllBy(
      {required String fieldName, int? limit, bool desc = true}) async {
    // Get docs from collection reference
    Query query = limit == null
        ? _collectionRef.orderBy(fieldName, descending: desc)
        : _collectionRef.orderBy(fieldName, descending: desc).limit(limit);

    QuerySnapshot querySnapshot = await query.get();

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

  Future add({
    required String title,
    required String jsonContent,
    required UserModel author,
    File? imageFile,
  }) async {
    try {
      dynamic add = await _collectionRef.add({
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      }).then((docRef) async {
        print('docRef: $docRef');
        if (imageFile != null) {
          print("Thumbnail included");

          // UPLOAD TO FIREBASE STORAGE
          // Get file extension
          String extension = path.extension(imageFile.path);
          print("Extension: $extension");

          // Create the file metadata
          final metadata = SettableMetadata(contentType: "image/jpeg");

          // Create a reference to the file path in Firebase Storage
          final storageRef = _firebaseStorage
              .ref()
              .child('news/thumbnail/${docRef.id}$extension');

          // Upload the file to Firebase Storage
          final uploadTask = storageRef.putFile(imageFile, metadata);

          uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress = 100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                print("Upload is $progress% complete.");
                break;
              case TaskState.paused:
                print("Upload is paused.");
                break;
              case TaskState.canceled:
                print("Upload was canceled");
                break;
              case TaskState.error:
                // Handle unsuccessful uploads
                print("Upload encounter error");
                throw Exception();
              case TaskState.success:
                // Handle successful uploads on complete
                print("News thumbnail uploaded");
                break;
            }
          });

          // Get the download URL of the uploaded file
          final downloadUrl =
              await uploadTask.then((TaskSnapshot taskSnapshot) async {
            final url = await taskSnapshot.ref.getDownloadURL();
            return url;
          });

          print("URL: $downloadUrl");

          // UPDATE ON FIRESTORE
          _collectionRef
              .doc(docRef.id)
              .set(NewsModel(
                id: docRef.id,
                title: title,
                author: author,
                jsonContent: jsonContent,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                imgPath: 'news/thumbnail/${docRef.id}$extension',
                imgURL: downloadUrl,
              ).toJson())
              .then((value) => print("News Added"));
        } else {
          print("Thumbnail not included");

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
              .then((value) => print("News Added"))
              .onError((error, stackTrace) => print("ERROR: $error"));
        }
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
    required UserModel editor,
    File? imageFile,
  }) async {
    try {
      if (imageFile != null) {
        // if previous thumbnail exist
        if (news.imgPath != null && news.imgURL != null) {
          print("Previous file exist");

          // delete previous file
          final Reference ref = _firebaseStorage.ref().child(news.imgPath!);
          await ref.delete();

          print("Previous file deleted");
        }

        // UPLOAD TO FIREBASE STORAGE
        // Get file extension
        String extension = path.extension(imageFile.path);
        print("Extension: $extension");

        // Create the file metadata
        final metadata = SettableMetadata(contentType: "image/jpeg");

        // Create a reference to the file path in Firebase Storage
        final storageRef =
            _firebaseStorage.ref().child('news/thumbnail/${news.id}$extension');

        // Upload the file to Firebase Storage
        final uploadTask = storageRef.putFile(imageFile, metadata);

        uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress = 100.0 *
                  (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
              print("Upload is paused.");
              break;
            case TaskState.canceled:
              print("Upload was canceled");
              break;
            case TaskState.error:
              // Handle unsuccessful uploads
              print("Upload encounter error");
              throw Exception();
            case TaskState.success:
              // Handle successful uploads on complete
              print("News thumbnail uploaded");
              break;
          }
        });

        // Get the download URL of the uploaded file
        final downloadUrl =
            await uploadTask.then((TaskSnapshot taskSnapshot) async {
          final url = await taskSnapshot.ref.getDownloadURL();
          return url;
        });

        print("URL: $downloadUrl");

        // UPDATE ON FIRESTORE
        dynamic result = _collectionRef.doc(news.id).update({
          'title': title,
          'jsonContent': jsonContent,
          'updatedBy': editor.id,
          'updatedAt': DateTime.now(),
          'imgPath': 'news/thumbnail/${news.id}$extension',
          'imgURL': downloadUrl,
        }).then((value) => print("News Edited"));

        print("Update News: $result");
      } else {
        dynamic result = _collectionRef.doc(news.id).update({
          'title': title,
          'jsonContent': jsonContent,
          'updatedBy': editor.id,
          'updatedAt': DateTime.now(),
        }).then((value) => print("News Edited"));

        print("Update News: $result");
      }

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
    required NewsModel news,
  }) async {
    try {
      // if previous thumbnail exist
      if (news.imgPath != null && news.imgURL != null) {
        print("Previous file exist");

        // delete previous file
        final Reference ref = _firebaseStorage.ref().child(news.imgPath!);
        await ref.delete();

        print("Previous file deleted");
      }

      final delete = _collectionRef.doc(news.id).delete();

      print("Delete News: $delete");

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          await UserActivityServices()
              .add(
                user: currentUser,
                description: "Delete News (Title: ${news.title})",
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

  Future like({required NewsModel news}) async {
    try {
      dynamic result = _collectionRef.doc(news.id).update({
        'likeCount': news.likeCount + 1,
      }).then((value) => print("News Liked"));

      print("Like News: $result");

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          await UserActivityServices()
              .add(
                user: currentUser,
                description: "Liked News (Title: ${news.title})",
                activityType: "news_like",
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

  Future star({required NewsModel news, required bool star}) async {
    try {
      dynamic result = _collectionRef.doc(news.id).update({
        'starred': star,
      }).then((value) => print("News Liked"));

      print("Like News: $result");

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
        if (currentUser != null) {
          await UserActivityServices()
              .add(
                user: currentUser,
                description: "Liked News (Title: ${news.title})",
                activityType: "news_like",
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

  Future<File> downloadThumbnail(NewsModel news) async {
    final response = await http.get(Uri.parse(news.imgURL!));
    final bytes = response.bodyBytes;
    final fileName = Uri.parse(news.imgURL!).pathSegments.last;
    final tempDir = await getTemporaryDirectory();
    final directory = await Directory('${tempDir.path}/news/thumbnail')
        .create(recursive: true);

    print("tempDir.path: ${tempDir.path}");
    print("fileName: $fileName");

    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);

    return file;
  }
}
