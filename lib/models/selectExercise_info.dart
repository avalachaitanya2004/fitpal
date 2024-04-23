import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/exerciseData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return "";
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}

class SelectedExcerciseInfo extends StatefulWidget {
  SelectedExcerciseInfo({super.key, required this.exersise});
  final ExerciseCard exersise;

  @override
  State<SelectedExcerciseInfo> createState() => _SelectedExcerciseInfoState();
}

class _SelectedExcerciseInfoState extends State<SelectedExcerciseInfo> {
  late VideoPlayerController _controller1;
  String? VideoPath(String name) {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['video'] as String?;
    } else {
      return "";
    }
  }

  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller1 = VideoPlayerController.asset(
        VideoPath(widget.exersise.name) ?? 'assets/videos/Runninginplace.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller1.initialize();

    // Use the controller to loop the video.
    _controller1.setLooping(true);
    super.initState();
  }

  String? generateInst(String name) {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['hintsForBeginners'] as String?;
    } else {
      return "";
    }
  }

  String? generateInfo(String name) {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['info'] as String?;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller1.play();
    return Container(
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
              widget.exersise.name.capitalize(),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
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
                      aspectRatio: _controller1.value.aspectRatio,
                      child: VideoPlayer(_controller1),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Instructions',
              style: TextStyle(color: Colors.blue, fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              generateInst(widget.exersise.name) ?? 'null',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Hints',
              style: TextStyle(color: Colors.blue, fontSize: 22),
            ),
            Text(
              generateInfo(widget.exersise.name) ?? 'null',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
