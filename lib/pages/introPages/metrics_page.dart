// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fit_pal/numberpicker/numberpicker.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

bool indx = true;

class _MetricsPageState extends State<MetricsPage> {
  double _currentDoubleValueftin = 3.0;
  int _currentValuecm = 91;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
            child: Text(
          'How tall are you?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const SizedBox(height: 100),
        if (indx)
          Container(
            height: 270,
            width: 500,
            child: Column(
              children: <Widget>[
                DecimalNumberPicker(
                  haptics: true,
                  value: _currentDoubleValueftin,
                  minValue: 3,
                  maxValue: 9,
                  decimalPlaces: 2,
                  onChanged: (value) =>
                      setState(() => _currentDoubleValueftin = value),
                ),
              ],
            ),
          )
        else
          Container(
            height: 270,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NumberPicker(
                  haptics: true,
                  value: _currentValuecm,
                  minValue: 91,
                  maxValue: 271,
                  onChanged: (value) => setState(() => _currentValuecm = value),
                ),
                const Text(
                  'cm',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.small(
              elevation: 0,
              onPressed: () {
                setState(() {
                  indx = true;
                  int inches = (_currentValuecm / 2.54).floor();
                  double foot = ((_currentValuecm / 2.54) / 12).floorToDouble();
                  _currentDoubleValueftin = foot + ((inches - foot * 12) / 100);
                  if (_currentValuecm == 91) {
                    _currentDoubleValueftin = 3.0;
                  }
                });
              },
              splashColor: Colors.grey[600],
              backgroundColor: indx ? Colors.black : Colors.white,
              child: Text(
                'Ft/in',
                style: TextStyle(
                  color: !indx ? Colors.black : Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            FloatingActionButton.small(
              elevation: 0,
              onPressed: () {
                setState(() {
                  indx = false;
                  _currentValuecm =
                      ((_currentDoubleValueftin.floor() * 12) * 2.54).floor() +
                          ((_currentDoubleValueftin -
                                      _currentDoubleValueftin.floor()) *
                                  254)
                              .floor();
                });
              },
              splashColor: Colors.grey[600],
              backgroundColor: !indx ? Colors.black : Colors.white,
              child: Text(
                'cm',
                style: TextStyle(
                  color: indx ? Colors.black : Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
