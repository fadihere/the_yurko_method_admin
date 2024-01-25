import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_images.dart';
import 'package:the_yurko_method/features/auth/presentation/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.logo,
              height: 574.h,
              width: 508.w,
            ),
          ),
          Center(
            child: Image.asset(
              AppImages.loding,
              height: 50.h,
              width: 50.w,
            ),
          ),
        ],
      ),
    );
  }
}
