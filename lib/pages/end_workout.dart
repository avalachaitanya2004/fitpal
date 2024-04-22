import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndWorkout extends StatelessWidget {
  const EndWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Congrats you have completed ur workouts'),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Done'))
        ],
      ),
    );
  }
}
