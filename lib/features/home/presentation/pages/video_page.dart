import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_fonts.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:the_yurko_method/features/home/presentation/pages/video_play_page.dart';
import 'package:the_yurko_method/features/master_class/screens/upload_master_video.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Master Class'.toUpperCase(),
              style: const TextStyle(
                  fontFamily: AppFonts.archivoBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: AppColors.black,
                  letterSpacing: 1),
            ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(const UploadMasterVideoPage()),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff93469F).withOpacity(0.25),
                        offset: const Offset(0, 10),
                        blurRadius: 30,
                        spreadRadius: 0,
                      )
                    ]),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'ADD',
                      style: TextStyle(
                          fontFamily: AppFonts.archivoBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirestoreQueryBuilder<Map<String, dynamic>>(
              query:
                  FirebaseFirestore.instance.collection(Collection.videos.name),
              builder: (context, snapshot, _) {
                if (snapshot.isFetching) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final videos = snapshot.docs
                      .map((e) => VideoModel.fromMap(e.data()))
                      .toList();
                  videos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];

                      return VideoTile(video: video);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
    required this.video,
  });

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(VideoPlayPage(video: video)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: video.thumbnail,
              imageBuilder: (context, image) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
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
                    '${'${video.duration.minutes}'.padLeft(2, "0")} min',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.inter14Normal400(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
