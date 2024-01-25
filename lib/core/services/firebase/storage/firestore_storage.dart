import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreStorage {
  Future<String> uploadFile(
      String filePath, void Function(UploadTask task) callBack) async {
    final String path =
        'photo/${FirebaseAuth.instance.currentUser!.uid}/${Timestamp.now().millisecondsSinceEpoch}';
    Reference firestore = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = firestore.putFile(File(filePath));
    TaskSnapshot snapshot = await uploadTask;
    final url = await snapshot.ref.getDownloadURL();
    log(url);

    return url;
  }
}
