import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fit_pal/utility/date_picker_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pages1 = PageController();
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
          const SizedBox(
            height: 20,
          ),
          // page view for calorie intake and exit with an indicator
          Container(
            // color: Colors.blue,
            // color: Colors.blue,
            height: 250,
            child: PageView(
              controller: _pages1,
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '1286',
                          style: TextStyle(
                            height: 0.8,
                            // fontFamily: 'Bebas_Neue',
                            letterSpacing: -10,
                            fontSize: 130,
                            color: Colors.white.withOpacity(0.9),
                            // backgroundColor: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Kcal left',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.blue,
                                  height: 80,
                                  // width: 90,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Protein'),
                                        Text('32%'),
                                      ],
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.red,
                                  height: 80,
                                  // width: 90,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Carbs'),
                                        Text('44%'),
                                      ],
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.green,
                                  height: 80,
                                  // width: 90,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Fat'),
                                        Text('28%'),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '1444',
                          style: TextStyle(
                            // fontFamily: 'Bebas_Neue',
                            height: 0.8,
                            letterSpacing: -10,
                            fontSize: 130,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Kcal to burn',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SmoothPageIndicator(
              controller: _pages1,
              count: 2,
              effect: const ScrollingDotsEffect(
                // border: Border.all(color: Colors.grey,width: 1),
                dotColor: Colors.white,
                activeDotColor: Color.fromARGB(255, 169, 131, 239),
                activeStrokeWidth: 2.6,
                activeDotScale: 1.0,
                maxVisibleDots: 5,
                radius: 8,
                spacing: 10,
                dotHeight: 9,
                dotWidth: 9,
              )),

          // A tab view for meals, activity, water.
        ],
      ),
    );
  }
}
