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
        color: Colors.white,
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
              image: DecorationImage(
                image: AssetImage('assets/images/back_image2.jpeg'),
                fit: BoxFit.cover,
              ),
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
                      Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('20 min'),
                            ),
                          )),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.bolt,
                              color: Colors.blue,
                            ),
                            Text(
                              '35 XP',
                              style: TextStyle(
                                  // color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
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
