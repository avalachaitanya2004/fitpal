import 'package:fit_pal/models/excercise_card.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/pages/perform_workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorkoutStart extends StatefulWidget {
  const WorkoutStart({super.key, required this.excercises, required this.XP});
  final List<Excersise> excercises;
  final int XP;

  @override
  State<WorkoutStart> createState() => _WorkoutStartState();
}

class _WorkoutStartState extends State<WorkoutStart> {
  @override
  void initState() {
    excercises = widget.excercises;
    super.initState();
    cal = totalCal();
  }

  double totalCal() {
    double s = 0;
    for (int i = 0; i < excercises.length; i++) {
      s += excercises[i].gettotcal()!;
    }
    return s;
  }

  double cal = 0;

  Widget buildStatsCard(
      String title, String value, IconData icon, Color iconColor) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  late List<Excersise> excercises;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: 'today-workout',
        child: Material(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  stretch: true,
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  pinned: true,
                  floating: true,
                  expandedHeight: 160,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 50),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Todays \nWorkouts',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    // height: 1000,
                    width: double.infinity,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Column(
                        //         children: [
                        //           Text(
                        //             '18 min',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 18),
                        //           ),
                        //           Text(
                        //             'Time',
                        //             style: TextStyle(
                        //                 color: Colors.black.withOpacity(0.5)),
                        //           ),
                        //         ],
                        //       ),
                        //       VerticalDivider(
                        //         color: Colors.black,
                        //         thickness: 3,
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             '+30',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 18),
                        //           ),
                        //           Text(
                        //             'XP',
                        //             style: TextStyle(
                        //                 color: Colors.black.withOpacity(0.5)),
                        //           ),
                        //         ],
                        //       ),
                        //       VerticalDivider(
                        //         color: Colors.black,
                        //         thickness: 3,
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             '500',
                        //             style: TextStyle(
                        //                 color: Colors.black, fontSize: 18),
                        //           ),
                        //           Text(
                        //             'KCal',
                        //             style: TextStyle(
                        //                 color: Colors.black.withOpacity(0.5)),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildStatsCard("Time", '18', CupertinoIcons.clock,
                                Colors.brown),
                            buildStatsCard("XP", '${widget.XP}',
                                CupertinoIcons.bolt, Colors.yellow.shade900),
                            buildStatsCard("Cal", cal.toStringAsFixed(2),
                                CupertinoIcons.flame, Colors.red),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Exercises (${excercises.length})',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            )),
                        Column(
                          children: List.generate(
                              excercises.length,
                              (index) =>
                                  ExcerciseCard(excersise: excercises[index])),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Positioned(
                  // left: 100,
                  bottom: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PerformWorkout(
                            excercises: excercises,
                            XP: widget.XP,
                          );
                        }));
                      },
                      child: Container(
                        width: 250,
                        height: 40,
                        // width: double.infinity,
                        // width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Start",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
