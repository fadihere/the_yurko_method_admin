import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/constants/app_colors.dart';
import 'package:the_yurko_method/core/constants/app_strings.dart';
import 'package:the_yurko_method/core/constants/app_style.dart';
import 'package:the_yurko_method/core/utils/validators/auth_validators.dart';
import 'package:the_yurko_method/core/widgets/app_appbar.dart';
import 'package:the_yurko_method/core/widgets/app_button.dart';
import 'package:the_yurko_method/features/auth/presentation/controller/sigin_controller.dart';

import '../../../../core/widgets/text_form_field.dart';
import 'forget_password_page.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 127.h,
                  child: Text(
                    AppStrings.logintoyouraccount,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.inter40Normal400(),
                  ),
                ),
                Form(
                  key: controller.siginKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'Email',
                        validator: emailValidator,
                        controller: controller.email,
                      ),
                      GetBuilder<SignInController>(
                        builder: (_) {
                          return CustomTextFormField(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: controller.obscureText
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: controller.showPassword,
                            ),
                            obscureText: controller.obscureText,
                            hintText: 'Password',
                            validator: passwordValidator,
                            controller: controller.password,
                          );
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 22.w,
                                height: 22.h,
                                child: GetBuilder<SignInController>(
                                  builder: (_) {
                                    return Checkbox(
                                      activeColor: AppColors.primary,
                                      value: controller.isRemember,
                                      onChanged: controller.onTapRemember,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                        (states) => const BorderSide(
                                          width: 1.0,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Remember me',
                                style: AppTextStyle.inter14Normal400().copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ForgetPasswordPage());
                            },
                            child: Text(
                              'Forgot the password?',
                              style: AppTextStyle.inter14Normal400().copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppButton(
                  text: 'Sign in',
                  onTap: controller.sigIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
