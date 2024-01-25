import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';

class AppRichText extends StatelessWidget {
  final String text1;
  final String text2;
  final Function() onTap;
  const AppRichText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: AppTextStyle.inter14Normal400().copyWith(
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: text2,
            style: AppTextStyle.inter14Normal400().copyWith(
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
