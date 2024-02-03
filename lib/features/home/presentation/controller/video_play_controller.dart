import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:the_yurko_method/core/services/firebase/database/firestore_service.dart';
import 'package:the_yurko_method/features/home/data/model/video_model.dart';
import 'package:video_player/video_player.dart';

import '../../data/model/view_model.dart';

class VideoPlayController extends GetxController {
  final VideoModel videoModel;
  VideoPlayController({required this.videoModel});
  VideoPlayerController? videoController;
  ChewieController? controller;
  final _firestore = FirestoreService();
  int weeklyViews = 00;
  int totalViews = 00;
  @override
  void onInit() async {
    getViews();
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(videoModel.url));
    await videoController!.initialize();
    controller = ChewieController(videoPlayerController: videoController!);
    update();
    super.onInit();
  }

  getViews() async {
    final views = await _firestore.getViews(videoModel);
    totalViews = views.length;
    weeklyViews = _getWeeklyViews(views);
    update();
  }

  int _getWeeklyViews(List<ViewModel> views) {
    List viewsDates = views.map((element) => element.viewAt).toList();
    viewsDates.removeWhere(
      (element) => isWithinRange(
        DateTime.now().subtract(const Duration(days: 7)),
        element,
        DateTime.now(),
      ),
    );
    return viewsDates.length;
  }

  bool isWithinRange(
      DateTime dateToCheck, DateTime startDate, DateTime endDate) {
    return dateToCheck.isAfter(startDate) && dateToCheck.isBefore(endDate);
  }

  @override
  void onClose() {
    videoController?.dispose();
    controller?.dispose();
    super.onClose();
  }
}
