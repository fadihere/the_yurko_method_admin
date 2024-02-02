import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:the_yurko_method/features/home/presentation/controller/user_controller.dart';
import 'package:the_yurko_method/features/home/presentation/pages/upload_video_page.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_style.dart';
import 'video_play_page.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              userController.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
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
                    videos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                    return ReorderableListView.builder(
                      shrinkWrap: true,
                      onReorder: (oldIndex, newIndex) async {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        Future.wait([
                          FirebaseFirestore.instance
                              .collection(Collection.videos.name)
                              .doc(videos[oldIndex].id)
                              .update(
                                  {'createdAt': videos[newIndex].createdAt}),
                          FirebaseFirestore.instance
                              .collection(Collection.videos.name)
                              .doc(videos[newIndex].id)
                              .update(
                                  {'createdAt': videos[oldIndex].createdAt}),
                        ]);
                      },
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return VideoTile(
                          key: ValueKey(video),
                          video: video,
                        );
                      },
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
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class VideoTile extends StatefulWidget {
  const VideoTile({
    super.key,
    required this.video,
  });

  final VideoModel video;

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(VideoPlayPage(video: widget.video)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage(widget.video.thumbnail),
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
                widget.video.title,
                style: AppTextStyle.inter24Normal400(),
              ),
              Text(
                '${'${widget.video.duration.minutes}'.padLeft(2, "0")} min',
                textAlign: TextAlign.start,
                style: AppTextStyle.inter14Normal400(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
