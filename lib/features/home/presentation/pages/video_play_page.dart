import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/features/home/presentation/controller/video_play_controller.dart';

class VideoPlayPage extends StatelessWidget {
  const VideoPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoPlayController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sit up Exercise',
          style: AppTextStyle.inter24Normal400().copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: GetBuilder<VideoPlayController>(
                      builder: (_) {
                        return Chewie(
                          controller: controller.controller,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Bodies lie flat on their backs, legs bent at a 90-degree angle, and fingers interlocked behind their heads. As they rise, torsos curl forward, revealing the strain in their abdominal muscles. The controlled ascent is met with a brief pause at the pinnacle, where core muscles engage in a fleeting isometric hold. Exhales punctuate the effort, creating a synchronized cadence that fills the air. Each repetition is a testament to resilience, as sweat-drenched brows and gritted teeth convey the physical and mental challenge of this timeless exercise.',
                    style: AppTextStyle.inter14Normal400().copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Duration',
                        style: AppTextStyle.inter18Normal700().copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        '12 min',
                        style: AppTextStyle.inter18Normal400().copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppButton(
              text: 'Delete Video',
              color: const Color(0xffFF3434),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
