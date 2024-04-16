import 'package:fit_pal/Controllers/hero_dialog_route.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/pages/workout_start_custom.dart';
import 'package:flutter/material.dart';

class CustomPlaylist {
  final String name;
  final List<Excersise> set;

  CustomPlaylist({required this.name, required this.set});
  int returnXP() {
    return 0;
  }
}

class CustomPlaylistCard extends StatelessWidget {
  const CustomPlaylistCard({super.key, required this.custom});
  final CustomPlaylist custom;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: custom.name,
      child: Material(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return WorkoutStartCustom(custom: custom);
            }));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${custom.name}',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )),
                      Spacer(),
                      Text('X${custom.set.length}'),
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
    );
  }
}
