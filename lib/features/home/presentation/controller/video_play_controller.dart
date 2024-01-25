import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayController extends GetxController {
  VideoPlayerController videoController = VideoPlayerController.networkUrl(
      Uri.parse(
          "https://media.istockphoto.com/id/1438537439/video/5g-wireless-network-signal-data-transmission-and-connection.mp4?s=mp4-640x640-is&k=20&c=2yV0gA112cj5sBzN93Q4lbW25kiZanU7agSjjOR4DEE="));
  late ChewieController controller;

  @override
  void onInit() {
    controller = ChewieController(
      videoPlayerController: videoController,
      allowFullScreen: true,
      autoPlay: true,
    );
    update();
    super.onInit();
  }
}
