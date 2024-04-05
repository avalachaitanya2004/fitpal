import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/perform_workout_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PerformWorkout extends StatelessWidget {
  PerformWorkout({super.key, required this.excercises});
  final List<Excersise> excercises;
  final PageController _pages = PageController();

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
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
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
              controller: _pages,
              children: List.generate(excercises.length,
                  (index) => PerformWorkoutCard(excersise: excercises[index])),
            ))),
          ],
        ),
      ),
    );
  }
}
