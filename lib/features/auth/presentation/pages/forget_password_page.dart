import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/utils/validators/auth_validators.dart';
import 'package:the_yurko_method/features/auth/presentation/controller/forget_controller.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/text_form_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forget Password",
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Enter your email address associated with your account we will send you a link to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Form(
                  key: controller.formkey,
                  child: CustomTextFormField(
                    labelText: "Email Address",
                    controller: controller.email,
                    validator: emailValidator,
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  text: "Submit",
                  onTap: controller.submit,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
