// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .set(userInfoMap);
  }
}

class FirebaseFirestore {
  // ignore: prefer_typing_uninitialized_variables
  static var instance;
}
