import 'package:fit_pal/models/custom_workouts.dart';
import 'package:fit_pal/models/excercise_card.dart';
import 'package:fit_pal/pages/perform_workout.dart';
import 'package:flutter/material.dart';

class WorkoutStartCustom extends StatefulWidget {
  const WorkoutStartCustom({super.key, required this.custom});
  final CustomPlaylist custom;

  @override
  State<WorkoutStartCustom> createState() => _WorkoutStartCustomState();
}

class _WorkoutStartCustomState extends State<WorkoutStartCustom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    custom = widget.custom;
  }

  late CustomPlaylist custom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Hero(
          tag: custom.name,
          child: Material(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    stretch: true,
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    title: Text(
                      'Todays Workouts',
                      style: TextStyle(color: Colors.black),
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
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      // height: 1000,
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
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '+30',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(
                                      'XP',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '500',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(
                                      'KCal',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  'Exercises (${custom.set.length})',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )),
                          Column(
                            children: List.generate(
                                custom.set.length,
                                (index) => ExcerciseCard(
                                    excersise: custom.set[index])),
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
                      child: Container(
                        width: 250,
                        height: 40,
                        // width: double.infinity,
                        // width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PerformWorkout(excercises: custom.set);
                            }));
                          },
                          child: Center(
                            child: Text(
                              "Start",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
