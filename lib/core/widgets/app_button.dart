import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? color;
  const AppButton(
      {super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 324.w,
        height: 49.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: color ?? AppColors.primary,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.inter14Normal400(),
          ),
        ),
      ),
    );
  }
}
