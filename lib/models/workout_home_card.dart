import 'package:fit_pal/Controllers/hero_dialog_route.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/pages/workout_start_page.dart';
import 'package:flutter/material.dart';

class WorkoutHomeCard extends StatelessWidget {
  const WorkoutHomeCard({super.key, required this.excercise});
  final List<Excersise> excercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              Colors.white.withOpacity(0.6),
              Color(0xFFF3E5F5)
            ], // Gradient colors
          ),
          // color: Colors.blue,
        ),
        margin: EdgeInsets.all(5),
        height: 160,
        width: double.maxFinite,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 15),
          child: Column(
            children: [
              // a row for title and three dots
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Todays Workouts',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Hero(
                    tag: 'today-workout',
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return WorkoutStart(excercises: excercise);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.menu),
                          ),
                        )),
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     '${food.name}',
              //     // textAlign: TextAlign.left,
              //     style: TextStyle(
              //         // backgroundColor: Colors.green,
              //         fontSize: 20,
              //         color: Colors.black),
              //   ),
              // ),

              // calories
              Spacer(),
              // a row for proteins etc and a plus icon
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.9),
                      ),
                      margin: EdgeInsets.all(4),
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Text(
                          'XP +35',
                          style: TextStyle(fontSize: 14),
                        )),
                      )),
                  Spacer(),
                  Text(
                    '1000 kcal',
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        // backgroundColor: Colors.green,
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.6)),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white.withOpacity(0.7),
                  //   child: Icon(Icons.add),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
