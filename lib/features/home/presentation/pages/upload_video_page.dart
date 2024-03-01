import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/utils/functions/functions.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/core/widgets/text_form_field.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../core/services/firebase/storage/firestore_storage.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  File? file;
  final picker = ImagePicker();
  Uint8List? imageBytes;
  bool isUploading = false;
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Video',
          style: AppTextStyle.inter24Normal400().copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: AppTextStyle.inter18Normal400(),
                  ),
                  CustomTextFormField(
                    controller: titleController,
                  ),
                  SizedBox(height: 20.h), // Adjust as needed
                  Text(
                    'Description',
                    style: AppTextStyle.inter18Normal400(),
                  ),
                  SizedBox(height: 8.h), // Adjust as needed
                  TextFormField(
                    maxLines: 3,
                    cursorColor: AppColors.primary,
                    controller: desController,
                    decoration: InputDecoration(
                      fillColor: const Color(0xffF1F1F1),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 18,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      suffixIconColor: const Color(0xff949393),
                      floatingLabelStyle: const TextStyle(fontSize: 12),
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff949393),
                      ),
                      prefixIconColor: const Color(0xff949393),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Adjust as needed
                  Text(
                    'Video',
                    style: AppTextStyle.inter18Normal400(),
                  ),
                  SizedBox(height: 8.h), // Adjust as needed
                  GestureDetector(
                    onTap: () {
                      _showPicker(context: context);
                    },
                    child: Container(
                      width: 84.w,
                      height: 84.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffD9D9D9),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                          child: file != null
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.add)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 180.h),
              isUploading
                  ? const CircularProgressIndicator()
                  : AppButton(
                      text: 'Upload',
                      onTap: () {
                        _uploadVideo();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  getVideo(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getVideo(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getVideo(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickVideo(
      source: img,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 10),
    );
    XFile? xfilePick = pickedFile;
    setState(() {
      if (xfilePick != null) {
        file = File(pickedFile!.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  Future<void> _uploadVideo() async {
    if (file == null ||
        titleController.text.isEmpty ||
        desController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select a video'),
        ),
      );
      return;
    }
    setState(() {
      isUploading = true;
    });

    String videoUrl = await FirestoreStorage().uploadVideo(file!);
    final thumbnailUint8List = await VideoThumbnail.thumbnailFile(
      video: file!.path,
      imageFormat: ImageFormat.PNG,
      quality: 75,
    );
    log(thumbnailUint8List.toString());
    if (thumbnailUint8List == null) return;
    String thumbnailUrl =
        await FirestoreStorage().uploadPhoto(File(thumbnailUint8List));
    final videoInfo = FlutterVideoInfo();

    final info = await videoInfo.getVideoInfo(file!.path);
    if (info == null) return;
    final duration = Duration(milliseconds: info.duration?.toInt() ?? 0);
    final video = VideoModel(
      id: getRandomString(25),
      url: videoUrl,
      title: titleController.text.trim(),
      description: desController.text.trim(),
      createdAt: DateTime.now(),
      weeklyViews: 0,
      totalViews: 0,
      thumbnail: thumbnailUrl,
      duration: DurationModel(
        minutes: duration.inMinutes,
        seconds: duration.inSeconds,
      ),
      pdfUrl: '',
      webLink: '',
      dateTime: dateTime.millisecondsSinceEpoch,
    );

    await FirestoreService().createVideo(video);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video uploaded successfully')),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    setState(() {
      isUploading = false;
      titleController.clear();
      desController.clear();
    });
  }
}
