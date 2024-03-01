import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/action_sheet.dart';

class HelperClass {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      return pickedFile;
    } catch (e) {
      return null;
    }
  }

  Future<XFile?> bottomSheetImagePicker(BuildContext context) async {
    XFile? file;
    await showAdaptiveActionSheet(
      context: context,
      title: const Text('Profile photo'),
      androidBorderRadius: 30,
      actions: [
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: () async {
              file = await _pickImage(ImageSource.gallery);
              // Get.back();
            }),
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: () async {
              file = await _pickImage(ImageSource.camera);
              // Get.back();
            }),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
    return file;
  }
}

Future getDocumentFile(Function(File file) pickedDocument) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['pdf'],
    type: FileType.custom,
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    pickedDocument.call(file);
    return;
  }
}

String formatDate(DateTime dateTime) {
  return dateTime.toString().substring(0, 10).replaceAll(RegExp(r'-'), '-');
}
