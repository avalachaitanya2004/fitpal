// import 'dart:js';

import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/perform_workout_card.dart';
import 'package:fit_pal/pages/interval_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PerformWorkout extends StatelessWidget {
  PerformWorkout({super.key, required this.excercises});
  final List<Excersise> excercises;
  final PageController _pages = PageController();
  void nextpage() {
    if (_pages.page! < excercises.length - 1) {
      _pages.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // void nextpage1() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return IntervalPage(nextpage: nextpage);
  //   }));
  // }

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
                count: excercises.length,
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
                  Text('Excercises')
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
                  excercises.length,
                  (index) => PerformWorkoutCard(
                        excersise: excercises[index],
                        nextpage: nextpage,
                      )),
            ))),
          ],
        ),
      ),
    );
  }
}
