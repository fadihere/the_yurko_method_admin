import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/features/auth/data/models/user_model.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:the_yurko_method/features/home/data/model/view_model.dart';

enum Collection { users, videos, views }

class FirestoreService {
  Future<bool> createUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(user.uid)
          .set(user.toMap());
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");

      return false;
    }
  }

  Future<bool> createVideo(VideoModel video) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.videos.name)
          .doc(video.id)
          .set(video.toMap());
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");

      return false;
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(uid)
          .get();

      return UserModel.fromMap(res.data()!);
    } on FirebaseException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(user.uid)
          .update(user.toMap());
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");
      return false;
    }
  }

  Future<List<ViewModel>> getViews(VideoModel video) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection(Collection.videos.name)
          .doc(video.id)
          .collection(Collection.views.name)
          .get();

      return res.docs.map((e) => ViewModel.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      log(e.message.toString());
      return [];
    }
  }
}
