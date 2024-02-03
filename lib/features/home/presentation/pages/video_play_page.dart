import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:the_yurko_method/features/home/presentation/controller/video_play_controller.dart';

import '../../../../core/widgets/dialog.dart';

class VideoPlayPage extends StatelessWidget {
  final VideoModel video;
  const VideoPlayPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoPlayController(videoModel: video));
    Future<void> deleteVideo() async {
      try {
        await FirebaseFirestore.instance
            .collection(Collection.videos.name)
            .doc(video.id)
            .delete();
        Get.back();
      } catch (e) {
        throw Exception(e.toString());
      }
    }

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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: GetBuilder<VideoPlayController>(
                        builder: (_) {
                          return controller.controller != null
                              ? Chewie(controller: controller.controller!)
                              : Container(
                                  color: Colors.grey.withOpacity(0.5),
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    video.description,
                    style: AppTextStyle.inter14Normal400().copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Duration',
                        style: AppTextStyle.inter18Normal700().copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        '${'${video.duration.minutes}'.padLeft(2, "0")} min',
                        style: AppTextStyle.inter18Normal400().copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Weekly Views',
                        style: AppTextStyle.inter18Normal700().copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GetBuilder<VideoPlayController>(
                        builder: (_) {
                          return Text(
                            '${controller.weeklyViews}'.padLeft(2, "0"),
                            style: AppTextStyle.inter18Normal400().copyWith(
                              color: AppColors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Total Views',
                        style: AppTextStyle.inter18Normal700().copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GetBuilder<VideoPlayController>(
                        builder: (_) {
                          return Text(
                            '${controller.totalViews}'.padLeft(2, "0"),
                            style: AppTextStyle.inter18Normal400().copyWith(
                              color: AppColors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppButton(
              text: 'Delete Video',
              color: const Color(0xffFF3434),
              onTap: () {
                AppDialog(context).showOSDialog(
                  title: "Message",
                  message: "Do you really want to delete this video?",
                  firstButtonText: "Cancel",
                  firstCallBack: () {
                    Get.back();
                  },
                  secondButtonColor: Colors.red,
                  secondButtonText: "Delete",
                  secondCallBack: () {
                    deleteVideo();
                    Get.back();
                  },
                );
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
