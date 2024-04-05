// import 'dart:js_interop_unsafe';

import 'package:bounce_tap/bounce_tap.dart';
import 'package:fit_pal/models/excercise_info.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExcerciseCard extends StatelessWidget {
  const ExcerciseCard({super.key, required this.excersise});
  final Excersise excersise;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      duration: Duration(milliseconds: 500),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExcerciseInfo(excersise: excersise);
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // picture
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  // color: Colors.getProperty(property),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    excersise.name,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'x ${excersise.reps}',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              )
              // Text
            ],
          ),
        ),
      ),
    );
  }
}
