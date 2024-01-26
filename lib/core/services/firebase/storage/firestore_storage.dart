import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreStorage {
  Future<String> uploadPhtoto(File file) async {
    try {
      final String path =
          'photo/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      Reference storageReference = FirebaseStorage.instance.ref().child(path);
      await storageReference.putFile(file);
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> uploadVideo(File file) async {
    try {
      final String path =
          'video/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      Reference storageReference = FirebaseStorage.instance.ref().child(path);
      await storageReference.putFile(file);
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      rethrow;
    }
  }
}
