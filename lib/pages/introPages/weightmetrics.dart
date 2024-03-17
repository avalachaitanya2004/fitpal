import 'package:flutter/material.dart';
import 'package:fit_pal/numberpicker/numberpicker.dart';

class WeightMetrics extends StatefulWidget {
  const WeightMetrics({super.key});

  @override
  State<WeightMetrics> createState() => _WeightMetricsState();
}

bool indx = true;

class _WeightMetricsState extends State<WeightMetrics> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'What\'s your current Weight?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 100),
        if (indx) _WeightInp() else _WeightInp2(),
        const SizedBox(height: 70),
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
                'kg',
                style: TextStyle(
                  color: !indx ? Colors.black : Colors.white,
                  fontSize: 15,
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
                'lb',
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

class _WeightInp extends StatefulWidget {
  @override
  __WeightInpState createState() => __WeightInpState();
}

class __WeightInpState extends State<_WeightInp> {
  double _currentDoubleValue = 30.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecimalNumberPicker2(
          value: _currentDoubleValue,
          minValue: 30,
          maxValue: 300,
          units: 'kg',
          decimalPlaces: 1,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
      ],
    );
  }
}

class _WeightInp2 extends StatefulWidget {
  @override
  __WeightInp2State createState() => __WeightInp2State();
}

class __WeightInp2State extends State<_WeightInp2> {
  double _currentDoubleValue = 66.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecimalNumberPicker2(
          value: _currentDoubleValue,
          minValue: 66,
          maxValue: 660,
          units: 'lb',
          decimalPlaces: 1,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
      ],
    );
  }
}
