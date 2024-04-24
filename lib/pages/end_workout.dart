import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndWorkout extends StatelessWidget {
  const EndWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('Congrats you have completed ur workouts'),
    //       ElevatedButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('Done'))
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 278,
              width: 278,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Success.png'),
                  scale: 2.0,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              'Exercise Completed',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            Text(
              'Yaay!! You are rocking today',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                height: 55,
                width: MediaQuery.sizeOf(context).width * 0.8,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
