import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/core/widgets/text_form_field.dart';
import 'package:the_yurko_method/features/home/presentation/controller/user_controller.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return;
    final image = File(pickedFile.path);
    final controller = Get.put(UserController());
    controller.uploadProfile(image);
  }

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
      body: Center(
        child: SizedBox(
          width: 324.w,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Title',
                          style: AppTextStyle.inter18Normal400(),
                        ),
                      ],
                    ),
                    const CustomTextFormField(),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: AppTextStyle.inter18Normal400(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                      child: Expanded(
                        child: TextFormField(
                          maxLines: 3,
                          cursorColor: AppColors.primary,
                          decoration: InputDecoration(
                            fillColor: const Color(0xffF1F1F1),
                            contentPadding: const EdgeInsets.only(
                              left: 18,
                              right: 20,
                              top: 12,
                              bottom: 12,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                            filled: true,
                            suffixIconColor: const Color(0xff949393),
                            floatingLabelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Color(0xff949393)),
                            prefixIconColor: const Color(0xff949393),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Video',
                          style: AppTextStyle.inter18Normal400(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showImageSourceBottomSheet();
                          },
                          child: Container(
                            width: 84.w,
                            height: 84.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffD9D9D9),
                              ),
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: const Color(0xffD9D9D9),
                                size: 80.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppButton(
                text: 'Upload',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            // ListTile(
            //   leading: const Icon(Icons.camera),
            //   title: const Text('Camera'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     _getImage(ImageSource.camera);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Select Video'),
              onTap: () {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}
