import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_images.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/features/home/presentation/pages/upload_video_page.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_style.dart';
import 'video_play_page.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  Text(
                    'Videos',
                    style: AppTextStyle.inter32Normal400().copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(const VideoPlayPage());
                      },
                      child: Container(
                        height: 150.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: const DecorationImage(
                            image: AssetImage(AppImages.image2),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Squat Movement Exercise ',
                                style: AppTextStyle.inter24Normal400(),
                              ),
                              Text(
                                '10 minutes ',
                                textAlign: TextAlign.start,
                                style: AppTextStyle.inter14Normal400(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  },
                  itemCount: 10,
                ),
              ),
              AppButton(
                text: 'Upload Video',
                onTap: () {
                  Get.to(const UploadVideoPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
