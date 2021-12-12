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

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  bool _showingNotes = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    print("_VideoPlayerClassState dispose()");
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    _videoPlayerController.initialize();
    _videoPlayerController.addListener(() {
      if(_videoPlayerController.value.position.inSeconds == 3) {
        if(_showingNotes == false)
          showNotesDialog();
      }
    });

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


  void showNotesDialog() {
    _showingNotes = true;
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 400,
            width: 350,
            child: getNotesColumn(),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Widget getNotesColumn() {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(icon: Icon(Icons.note_add, size: 30, color: Colors.amberAccent,)),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0),
                  child: Text('CREATE NOTE',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.blue),),
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.cancel, size: 30, color: Colors.grey,), onPressed: (){
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }),
              ],
            ),
            Container(
              height: 250,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 50,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Insert text here...',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  )
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 20),
              child: InkWell(onTap: () {
                if (_textEditingController.text.isNotEmpty && Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
                  child: Text('SAVE NOTE', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400))
              ),
            ),
          ],
        ),
      ),
    );
  }

}