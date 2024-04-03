import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutStart extends StatefulWidget {
  const WorkoutStart({super.key});

  @override
  State<WorkoutStart> createState() => _WorkoutStartState();
}

class _WorkoutStartState extends State<WorkoutStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            surfaceTintColor: Colors.black,
            backgroundColor: Colors.black,
            title: Text(
              'Todays Workouts',
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.arrow_back),
            pinned: true,
            floating: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              // title: Center(child: Text('Todays Workouts')),
              background: Image.asset(
                'assets/images/Workout_demo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                // borderRadius: BorderRadius.circular(20),
              ),
              height: 1000,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '18 min',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'Time',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          thickness: 3,
                        ),
                        Column(
                          children: [
                            Text(
                              '+30',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'XP',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          thickness: 3,
                        ),
                        Column(
                          children: [
                            Text(
                              '500',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'KCal',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
            ))
      ],
    ));
  }
}
