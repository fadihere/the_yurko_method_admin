import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/features/auth/presentation/pages/splash_page.dart';

import 'core/config/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(350, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        theme: AppTheme().light,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
