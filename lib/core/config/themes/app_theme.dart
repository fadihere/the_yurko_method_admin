import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppTheme {
  ThemeData get light => ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      );
}
