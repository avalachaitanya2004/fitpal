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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1)),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // picture
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 60,
                  width: 60,
                  // color: Colors.getProperty(property),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                      scale: 0.5,
                      image: AssetImage(excersise.ImagePath() ??
                          'assets/images/back_image.jpeg'),
                      fit: BoxFit.fill,
                    ),
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
                  excersise.returnBool() ?? false
                      ? Text(
                          'x ${excersise.reps}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      : Text(
                          '${excersise.reps} s',
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
