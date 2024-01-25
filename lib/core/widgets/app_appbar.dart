import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: AppBar(
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
    );
  }
}
