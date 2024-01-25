import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/features/auth/presentation/pages/signin_page.dart';
import 'package:the_yurko_method/features/home/presentation/controller/user_controller.dart';
import 'package:the_yurko_method/features/home/presentation/pages/video_page.dart';
import '../../../../core/services/firebase/database/firestore_service.dart';

class SplashController extends GetxController {
  final _userController = Get.put(UserController());
  final _firestoreService = FirestoreService();
  final _auth = FirebaseAuth.instance;

  @override
  onInit() {
    navigateUser();
    super.onInit();
  }

  Future<void> navigateUser() async {
    await Future.delayed(const Duration(seconds: 5));
    final user = _auth.currentUser;
    if (user == null) {
      Get.offAll(const SigninPage());
      return;
    }
    final userModel = await _firestoreService.getUser(user.uid);
    if (userModel == null) {
      Get.offAll(const SigninPage());
      return;
    }
    _userController.user = userModel;
    Get.offAll(const VideoPage());
    return;
  }
}
