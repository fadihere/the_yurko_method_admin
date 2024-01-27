import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayController extends GetxController {
  final String videoUrl;
  VideoPlayController({required this.videoUrl});
  VideoPlayerController? videoController;
  ChewieController? controller;

  @override
  void onInit() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController!.initialize();
    controller = ChewieController(
      videoPlayerController: videoController!,
    );
    update();
    super.onInit();
  }

  @override
  void onClose() {
    videoController?.dispose();
    controller?.dispose();

    super.onClose();
  }
}
