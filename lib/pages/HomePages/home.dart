import 'package:flutter/material.dart';

import 'package:fit_pal/utility/date_picker_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: Duration(seconds: 1),
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: RadialGradient(
        radius: 1.5,
        // center: Alignment(0, _pos.value),
        center: Alignment(0, -1),
        // radius:0.5,
        colors: [Color.fromARGB(255, 123, 69, 232), Colors.white],
        stops: [0.0, 1.0],
      )),
      // color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  // _selectedValue = date;
                });
              },
            ),
          ),

          // page view for calorie intake and exit with an indicator
          Container(
            // color: Colors,
            height: 250,
            child: PageView(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      '1286',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      '1444',
                      style: TextStyle(
                        fontSize: 70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

          // A tab view for meals, activity, water.
        ],
      ),
    );
  }
}
