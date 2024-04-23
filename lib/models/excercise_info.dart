import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExcerciseInfo extends StatefulWidget {
  const ExcerciseInfo({super.key, required this.excersise});
  final Excersise excersise;

  @override
  State<ExcerciseInfo> createState() => _ExcerciseInfoState();
}

class _ExcerciseInfoState extends State<ExcerciseInfo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    // TODO: implement initState
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
        widget.excersise.VideoPath() ?? 'assets/videos/Runninginplace.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    super.initState();
  }

  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.play();
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.excersise.name,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage(widget.excersise.ImagePath() ??
                    //         'assets/images/back_image.jpeg')),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: 200,
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
              SizedBox(height: 20),
              Text(
                'About',
                style: TextStyle(color: Colors.blue, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                widget.excersise.generateInfo() ?? 'No information available',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Instructions',
                style: TextStyle(color: Colors.blue, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                widget.excersise.generateInst() ?? 'No information available',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
