import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fit_pal/numberpicker/numberpicker.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

bool indx = true;

class _MetricsPageState extends State<MetricsPage> {
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
        if (indx) _HeightInp() else _HeightInp2(),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.small(
              elevation: 0,
              onPressed: () {
                setState(() {
                  indx = true;
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

class _HeightInp extends StatefulWidget {
  @override
  __HeightInpState createState() => __HeightInpState();
}

class __HeightInpState extends State<_HeightInp> {
  double _currentDoubleValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 500,
      child: Column(
        children: <Widget>[
          DecimalNumberPicker(
            value: _currentDoubleValue,
            minValue: 3,
            maxValue: 9,
            decimalPlaces: 2,
            onChanged: (value) => setState(() => _currentDoubleValue = value),
          ),
        ],
      ),
    );
  }
}

class _HeightInp2 extends StatefulWidget {
  @override
  __HeightInp2State createState() => __HeightInp2State();
}

class __HeightInp2State extends State<_HeightInp2> {
  int _currentValue = 91;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NumberPicker(
            value: _currentValue,
            minValue: 91,
            maxValue: 271,
            onChanged: (value) => setState(() => _currentValue = value),
          ),
          const Text(
            'cm',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
