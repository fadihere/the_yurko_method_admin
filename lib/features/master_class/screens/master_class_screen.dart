import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/features/master_class/screens/upload_master_video.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/services/firebase/database/firestore_service.dart';
import '../../home/data/model/video_model.dart';
import '../../home/presentation/pages/video_page.dart';

class MasterClass extends StatelessWidget {
  const MasterClass({super.key});

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
              query: FirebaseFirestore.instance
                  .collection(Collection.masterVideos.name),
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
