import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class _AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
}

class SignInService extends _AuthService {
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(const Duration(seconds: 5));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");
      return null;
    }
  }
}

class SignUpService extends _AuthService {
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(const Duration(seconds: 5));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");
    }
    return null;
  }
}

class SignOutService extends _AuthService {
  Future<bool> signOut() async {
    bool isSuccess = false;
    try {
      await _auth.signOut().timeout(const Duration(seconds: 5));
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");
    }
    return isSuccess;
  }
}

class ForgetPasswordService extends _AuthService {
  Future<bool> forgetPassword(String email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .timeout(const Duration(seconds: 5));
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? "something went wrong");
      return false;
    }
  }
}
