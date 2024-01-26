import 'dart:io';

import 'package:get/get.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/core/utils/helper/loading_helper.dart';
import 'package:the_yurko_method/core/widgets/dialog.dart';
import 'package:the_yurko_method/features/auth/data/models/user_model.dart';
import 'package:the_yurko_method/features/auth/presentation/pages/signin_page.dart';

import '../../../../core/services/firebase/auth/firebase_auth_service.dart';
import '../../../../core/services/firebase/storage/firestore_storage.dart';

class UserController extends GetxController {
  late UserModel user;
  final _firestoreStorage = FirestoreStorage();
  final _firestoreService = FirestoreService();

  String get fullName => "${user.firstName} ${user.lastName}";
  String get email => user.email;
  String? get profile => user.profileUrl;

  void logout() async {
    LoadingHelper.showLoading();
    final isSuccess = await SignOutService().signOut();
    LoadingHelper.hideLoading();
    if (!isSuccess) {
      AppDialog(Get.context!).showOSDialog(
        title: "Sorry",
        message: "Something went wrong. Please try again!",
        firstCallBack: () {},
        secondButtonText: "Okay",
        secondCallBack: () {},
      );
      return;
    }
    Get.offAll(const SigninPage());
  }

  void uploadProfile(File image) async {
    LoadingHelper.showLoading();
    final url = await _firestoreStorage.uploadPhtoto(image);
    user = user.copyWith(profileUrl: url);
    _firestoreService.updateUser(user);
    LoadingHelper.hideLoading();
    update();
  }
}
