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

  @override
  void dispose() {
    print("_VideoPlayerClassState dispose()");
    _controller.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}