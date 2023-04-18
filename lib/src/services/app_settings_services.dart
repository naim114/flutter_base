import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_base/src/model/app_settings_model.dart';
import 'package:network_info_plus/network_info_plus.dart';

class AppSettingsServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection('Settings');

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final NetworkInfo _networkInfo = NetworkInfo();

  Stream<AppSettingsModel> getAppSettingsStream() {
    return collectionRef.doc('application').snapshots().map((snapshot) {
      return AppSettingsModel.fromMap(snapshot.data()!);
    });
  }
}
