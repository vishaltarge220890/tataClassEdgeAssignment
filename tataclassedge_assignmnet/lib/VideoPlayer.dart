import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerClass extends StatefulWidget {
  VideoPlayerClass({Key key, this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  _VideoPlayerClassState createState() => _VideoPlayerClassState();
}

class _VideoPlayerClassState extends State<VideoPlayerClass> {

  VideoPlayerController _controller;
  ChewieController _chewieController;
  Chewie _playerWidget;

  @override
  void dispose() {
    print("_VideoPlayerClassState dispose()");
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
    );

    _controller.initialize();
    _playerWidget = Chewie(
      controller: _chewieController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Center(
          child: _chewieController != null &&
              _chewieController.videoPlayerController.value.initialized
              ? Chewie(
            controller: _chewieController,
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

}