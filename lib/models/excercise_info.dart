import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExcerciseInfo extends StatelessWidget {
  const ExcerciseInfo({super.key, required this.excersise});
  final Excersise excersise;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 500,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            // a bar to drag and close
            Container(
              height: 8,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),

            // name
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  excersise.name,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.w900),
                )),
            SizedBox(
              height: 20,
            ),

            //video
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // access to edit or no

                      //instruction
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Instructions',
                          style: TextStyle(color: Colors.blue, fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        excersise.generateInst(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Focus Area',
                          style: TextStyle(color: Colors.blue, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
