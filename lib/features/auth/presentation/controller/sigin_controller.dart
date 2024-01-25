import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/utils/helper/loading_helper.dart';
import 'package:the_yurko_method/core/widgets/dialog.dart';
import 'package:the_yurko_method/features/home/presentation/controller/user_controller.dart';

import '../../../../core/services/firebase/auth/firebase_auth_service.dart';
import '../../../../main.dart';
import '../../../home/presentation/pages/video_page.dart';

enum AuthKeys { email, password, remember }

class SignInController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> siginKey = GlobalKey<FormState>();
  bool obscureText = true;
  final userController = Get.put(UserController());
  bool isRemember = false;

  final _siginService = SignInService();
  final _firestoreService = FirestoreService();

  @override
  void onInit() {
    email.text = prefs.getString(AuthKeys.email.name) ?? '';
    password.text = prefs.getString(AuthKeys.password.name) ?? '';
    isRemember = prefs.getBool(AuthKeys.remember.name) ?? false;
    super.onInit();
  }

  void onTapRemember(bool? value) {
    isRemember = value ?? false;
    update();
  }

  void showPassword() {
    obscureText = !obscureText;
    update();
  }

  Future<void> sigIn() async {
    if (!siginKey.currentState!.validate()) return;
    LoadingHelper.showLoading();
    final user = await _siginService.signInWithEmailAndPassword(
        email.text.trim(), password.text);
    LoadingHelper.hideLoading();
    if (user == null) return;
    LoadingHelper.showLoading();
    final userModel = await _firestoreService.getUser(user.user!.uid);
    LoadingHelper.hideLoading();
    if (userModel == null) return;
    final isAdmin = userModel.role == "admin";
    if (!isAdmin) {
      AppDialog(Get.context!).showOSDialog(
        title: "Sorry",
        message: "You are not authorised to access admin panel",
        firstCallBack: () {},
        secondButtonText: "Okay",
        secondCallBack: () {},
      );
      return;
    }
    userController.user = userModel;
    _rememberMe();
    Get.offAll(() => const VideoPage());
  }

  _rememberMe() async {
    if (isRemember) {
      await prefs.setBool(AuthKeys.remember.name, isRemember);
      await prefs.setString(AuthKeys.email.name, email.text.trim());
      await prefs.setString(AuthKeys.password.name, password.text);
      return;
    }
    await prefs.clear();
  }
}
