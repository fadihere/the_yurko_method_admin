import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/services/firebase/auth/firebase_auth_service.dart';

import '../../../../core/utils/helper/loading_helper.dart';
import '../../../../core/widgets/dialog.dart';

class ForgetController extends GetxController {
  final email = TextEditingController();
  final _forgetService = ForgetPasswordService();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  submit() async {
    if (!formkey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      LoadingHelper.showLoading();
      final isSucess = await _forgetService.forgetPassword(email.text.trim());
      LoadingHelper.hideLoading();
      if (!isSucess) return;
      email.clear();
      AppDialog(Get.context!).showOSDialog(
        title: "Success",
        message:
            "Password reset request was sent successfully. Please check your email to reset your password",
        secondButtonText: "Done",
        secondCallBack: () {
          Get.back();
          Get.back();
        },
        firstCallBack: () {},
      );
    } catch (e) {
      LoadingHelper.hideLoading();
    }
  }
}
