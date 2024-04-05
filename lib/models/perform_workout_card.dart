import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PerformWorkoutCard extends StatelessWidget {
  const PerformWorkoutCard({super.key, required this.excersise});
  final Excersise excersise;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.white10,
              )),
          Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          excersise.name,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '00:18',
                        style: TextStyle(color: Colors.white, fontSize: 80),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: 130,
                              height: 50,
                              child: Icon(
                                Icons.pause_rounded,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                                backgroundColor: Colors.black26,
                                child: Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 30,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}
