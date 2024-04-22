// import 'dart:js';

import 'dart:async';

import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/perform_workout_card.dart';
import 'package:fit_pal/pages/end_workout.dart';
import 'package:fit_pal/pages/interval_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PerformWorkout extends StatefulWidget {
  PerformWorkout({super.key, required this.excercises});
  final List<Excersise> excercises;

  @override
  State<PerformWorkout> createState() => _PerformWorkoutState();
}

class _PerformWorkoutState extends State<PerformWorkout> {
  final PageController _pages = PageController();

  void nextpage() {
    if (_pages.page! < widget.excercises.length - 1) {
      _pages.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      if (_pages.page! == widget.excercises.length - 1) {}
    }
  }

  int time = 0;
  void startTimer() {
    setState(() {
      // isrun = true;
    });
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        // if (time == 0) {
        //   setState(() {
        //     timer.cancel();
        //     // isrun = false;
        //   });
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return IntervalPage(nextpage: nextpage);
        //   }));
        //   // nextpage();
        // } else {
        //   setState(() {
        //     time--;
        //   });
        // }
        setState(() {
          time++;
        });
      },
    );
  }

  // void nextpage1() {
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // a progress indicator
            SmoothPageIndicator(
                controller: _pages,
                count: widget.excercises.length,
                effect: const SlideEffect(
                  // border: Border.all(color: Colors.grey,width: 1),
                  dotColor: Colors.grey,
                  activeDotColor: Colors.black,
                  // activeStrokeWidth: 2.6,
                  // activeDotScale: 1.0,
                  // maxVisibleDots: 5,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 6,
                  dotWidth: 20,
                )),
            //quit button and number completed
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('Excercises'),
                      Text('$time s'),
                    ],
                  )
                ],
              ),
            ),

            //animation and countdown
            Expanded(
                child: Container(
                    child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pages,
              children: List.generate(
                  widget.excercises.length,
                  (index) => PerformWorkoutCard(
                        excersise: widget.excercises[index],
                        nextpage: nextpage,
                        pagenumber: index,
                        lastpage: widget.excercises.length,
                      )),
            ))),
          ],
        ),
      ),
    );
  }
}
