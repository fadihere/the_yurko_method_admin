import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';

class LoadingHelper {
  static showLoading() {
    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetPlatform.isAndroid
                ? const CircularProgressIndicator(color: AppColors.primary)
                : const CupertinoActivityIndicator(color: AppColors.primary)
          ],
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.white.withOpacity(0.5),
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
