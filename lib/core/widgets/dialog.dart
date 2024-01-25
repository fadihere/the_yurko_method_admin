import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppDialog {
  final BuildContext context;
  AppDialog(this.context);
  Future<void> showOSDialog({
    required String title,
    required String message,
    String? firstButtonText,
    required VoidCallback firstCallBack,
    required String secondButtonText,
    required VoidCallback secondCallBack,
    bool? isHost,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          title: title,
          description: message,
          firstButtonText: firstButtonText ?? "",
          firstCallback: firstCallBack,
          secondButtonText: secondButtonText,
          secondCallback: secondCallBack,
        );
      },
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, firstButtonText, secondButtonText;
  final VoidCallback firstCallback, secondCallback;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.firstCallback,
    required this.secondCallback,
    required this.firstButtonText,
    required this.secondButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: firstCallback,
                      child: const Padding(
                        padding: EdgeInsets.all(1),
                        child: Icon(Icons.close),
                      ))
                ],
              ),
              const SizedBox(height: 24),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: firstButtonText.isNotEmpty,
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      onPressed: firstCallback,
                      child: Text(
                        firstButtonText,
                        softWrap: true,
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    splashColor: Colors.transparent,
                    elevation: 0,
                    disabledElevation: 0,
                    onPressed: secondCallback,
                    color: AppColors.primary,
                    child: Text(
                      secondButtonText,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
