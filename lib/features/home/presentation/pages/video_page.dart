import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection(Collection.videos.name)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final videos = snapshot.data!.docs
                          .map((e) => VideoModel.fromMap(e.data()))
                          .toList();
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return GestureDetector(
                            onTap: () => Get.to(VideoPlayPage(video: video)),
                            child: Container(
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(video.thumbnail),
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
                                      video.title,
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
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemCount: videos.length,
                      );
                    }
                  },
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
