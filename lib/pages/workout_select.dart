import 'package:fit_pal/Controllers/hero_dialog_route.dart';
import 'package:fit_pal/models/custom_workouts.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/pages/create_playlist.dart';
import 'package:fit_pal/pages/workout_start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorkoutSelect extends StatefulWidget {
  const WorkoutSelect({super.key});

  @override
  State<WorkoutSelect> createState() => _WorkoutSelectState();
}

class _WorkoutSelectState extends State<WorkoutSelect> {
  final List<Excersise> today = [
    Excersise(name: "JUMPING JACKS", reps: 20),
    Excersise(name: "ABDOMINAL CRUNCHES", reps: 20),
    Excersise(name: "RUSSIAN TWIST", reps: 20)
  ];

  final List<CustomPlaylist> custom = [
    CustomPlaylist(name: 'Playlist-1', set: [
      Excersise(name: "JUMPING JACKS", reps: 20),
      Excersise(name: "ABDOMINAL CRUNCHES", reps: 20),
      Excersise(name: "RUSSIAN TWIST", reps: 20)
    ]),
    CustomPlaylist(name: 'Playlist-2', set: [
      Excersise(name: "JUMPING JACKS", reps: 20),
      Excersise(name: "ABDOMINAL CRUNCHES", reps: 20),
      Excersise(name: "RUSSIAN TWIST", reps: 20)
    ]),
    CustomPlaylist(name: 'Playlist-3', set: [
      Excersise(name: "JUMPING JACKS", reps: 20),
      Excersise(name: "ABDOMINAL CRUNCHES", reps: 20),
      Excersise(name: "RUSSIAN TWIST", reps: 20)
    ]),
    CustomPlaylist(name: 'Playlist-4', set: [
      Excersise(name: "JUMPING JACKS", reps: 20),
      Excersise(name: "ABDOMINAL CRUNCHES", reps: 20),
      Excersise(name: "RUSSIAN TWIST", reps: 20)
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // todays workouts(only 1 set)
                // Align(
                //     alignment: Alignment.topLeft, child: Text('Todays Workouts')),
                const SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: 'today-workout',
                  child: Material(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return WorkoutStart(
                            excercises: today,
                          );
                        }));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/back_image.jpeg'),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Todays Workout',
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        )),
                                    Spacer(),
                                    Text('X${today.length}'),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text('20 min'),
                                    Spacer(),
                                    Text('+35 XP'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // cutomized workouts
                Row(
                  children: [
                    Text(
                      "Custom Workouts",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePlaylist()));
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.add),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(custom.length, (index) {
                    return CustomPlaylistCard(custom: custom[index]);
                  }),
                ),
                SizedBox(
                  height: 76,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
