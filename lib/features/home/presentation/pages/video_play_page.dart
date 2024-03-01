import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_fonts.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              video.title.toUpperCase(),
              style: const TextStyle(
                  fontFamily: AppFonts.archivoBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: AppColors.black,
                  letterSpacing: 1),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Column(
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
                SizedBox(height: 30.h),
                Text(
                  video.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontFamily: AppFonts.archivoBlack,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        )
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Duration',
                              style: TextStyle(
                                  fontFamily: AppFonts.archivoBlack,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.black)),
                          const Spacer(),
                          Text(
                            '${'${video.duration.minutes}'.padLeft(2, "0")} min',
                            style: const TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.black),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xffB9B9B9),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Weekly Views',
                            style: TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.black),
                          ),
                          const Spacer(),
                          Text(
                            '${controller.weeklyViews}'.padLeft(2, "0"),
                            style: const TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.black),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xffB9B9B9),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Total Views',
                            style: TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.black),
                          ),
                          const Spacer(),
                          Text(
                            '${controller.totalViews}'.padLeft(2, "0"),
                            style: const TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
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
