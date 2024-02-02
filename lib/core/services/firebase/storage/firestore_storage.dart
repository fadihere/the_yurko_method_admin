import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestoreStorage {
  Future<String> uploadPhoto(File file) async {
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
