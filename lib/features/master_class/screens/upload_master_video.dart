// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_images.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/utils/functions/functions.dart';
import 'package:the_yurko_method/core/utils/helper/helper_class.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/core/widgets/text_form_field.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../core/services/firebase/storage/firestore_storage.dart';
import '../../../core/constants/app_fonts.dart';

class UploadMasterVideoPage extends StatefulWidget {
  const UploadMasterVideoPage({Key? key}) : super(key: key);

  @override
  State<UploadMasterVideoPage> createState() => _UploadMasterVideoPageState();
}

class _UploadMasterVideoPageState extends State<UploadMasterVideoPage> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final weblinkController = TextEditingController();

  File? file;
  File? thumbnail;
  File? pdfFile;
  final picker = ImagePicker();
  Uint8List? imageBytes;
  bool isUploading = false;
  bool isUploadNow = false;
  bool isSchedule = false;
  DateTime dateTime = DateTime.now();
  String time = '';
  String date = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Master Class'.toUpperCase(),
          style: const TextStyle(
              fontFamily: AppFonts.archivoBlack,
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: AppColors.black,
              letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(
                        fontFamily: AppFonts.archivoBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                  CustomTextFormField(
                    controller: titleController,
                  ),
                  SizedBox(height: 20.h), // Adjust as needed
                  const Text(
                    'Description',
                    style: TextStyle(
                        fontFamily: AppFonts.archivoBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 1),
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
                  Wrap(
                    spacing: 22,
                    runSpacing: 10,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Video',
                            style: TextStyle(
                              fontFamily: AppFonts.archivoBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _showPicker(context: context);
                            },
                            child: Container(
                              height: 84,
                              width: 84,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: const Color(0xffD9D9D9)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0)
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: file != null
                                    ? const Icon(Icons.play_arrow)
                                    : SvgPicture.asset(AppSvg.video),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Thumbnail',
                            style: TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                letterSpacing: 1),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _showImagePicker(context: context);
                            },
                            child: Container(
                              height: 84,
                              width: 84,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0)
                                ],
                                border: Border.all(
                                    width: 1, color: const Color(0xffD9D9D9)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: thumbnail != null
                                    ? Image.file(
                                        thumbnail!,
                                        height: 84,
                                        width: 84,
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(AppSvg.imageSvg),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'PDF',
                            style: TextStyle(
                                fontFamily: AppFonts.archivoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                letterSpacing: 1),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              getDocumentFile((file) {
                                setState(() {
                                  pdfFile = file;
                                  log(pdfFile!.path.toString());
                                });
                              });
                            },
                            child: Container(
                              height: 84,
                              width: 84,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0)
                                ],
                                border: Border.all(
                                    width: 1, color: const Color(0xffD9D9D9)),
                              ),
                              child: pdfFile != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.pdfPng,
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.contain,
                                          ),
                                          Text(
                                            pdfFile!.path.split('/').last,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: SvgPicture.asset(AppSvg.pdfSvg),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h), // Adjust as needed
                  const Text(
                    'Webinar link (Optional)',
                    style: TextStyle(
                        fontFamily: AppFonts.archivoBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 1),
                  ),
                  CustomTextFormField(controller: weblinkController),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        isSchedule = false;
                        isUploadNow = !isUploadNow;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: isUploadNow
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffD9D9D9),
                              )),
                          child: isUploadNow
                              ? const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  width: 18,
                                  height: 18,
                                ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Upload Now',
                          style: TextStyle(
                              fontFamily: AppFonts.archivoBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        isUploadNow = false;
                        isSchedule = !isSchedule;
                        time = DateFormat('hh:mm a (zzz)')
                            .format(DateTime.now().toLocal());

                        date = formatDate(DateTime.now().toLocal());
                        log('Time : $time | Date : $date');
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color:
                                  isSchedule ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffD9D9D9),
                              )),
                          child: isSchedule
                              ? const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  width: 18,
                                  height: 18,
                                ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Schedule Post',
                          style: TextStyle(
                              fontFamily: AppFonts.archivoBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 14.h),
              if (isSchedule)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    pickDateTime(context).then((value) {
                      setState(() {
                        if (value != null) {
                          time = DateFormat('hh:mm a (zzz)')
                              .format(value.toLocal());
                          log(time);
                          date = formatDate(value);

                          dateTime = value.toLocal();
                        }
                      });
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                        color: const Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(AppSvg.dateTimeSvg),
                        Text(
                          date,
                          style: const TextStyle(
                              fontFamily: AppFonts.archivoBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 1),
                        ),
                        Text(
                          '$time (EST)',
                          style: const TextStyle(
                              fontFamily: AppFonts.archivoBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 50.h),
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

  void _showImagePicker({
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
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
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

  Future getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(
      source: img,
      preferredCameraDevice: CameraDevice.front,
    );
    XFile? xfilePick = pickedFile;
    setState(() {
      if (xfilePick != null) {
        thumbnail = File(pickedFile!.path);
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
        desController.text.isEmpty ||
        pdfFile == null) {
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
    if (thumbnail == null) {
      final thumbnailUint8List = await VideoThumbnail.thumbnailFile(
        video: file!.path,
        imageFormat: ImageFormat.PNG,
        quality: 75,
      );

      log(thumbnailUint8List.toString());
      if (thumbnailUint8List == null) return;
      thumbnail = File(thumbnailUint8List);
    }
    if (thumbnail == null) return;
    String thumbnailUrl = await FirestoreStorage().uploadPhoto(thumbnail!);
    String pdf = await FirestoreStorage().uploadPhoto(pdfFile!);

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
      pdfUrl: pdf,
      webLink: weblinkController.text.trim(),
      dateTime: dateTime.millisecondsSinceEpoch,
    );

    await FirestoreService().createMasterVideo(video);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video uploaded successfully')),
    );

    Navigator.pop(context);

    setState(() {
      isUploading = false;
      titleController.clear();
      desController.clear();
    });
  }

  Future<DateTime?> pickDateTime(BuildContext context) async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) {
      return null;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (pickedTime == null) {
      return null;
    }

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}
