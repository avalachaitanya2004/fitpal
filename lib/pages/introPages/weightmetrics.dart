import 'package:flutter/material.dart';
import 'package:fit_pal/numberpicker/numberpicker.dart';

class WeightMetrics extends StatefulWidget {
  const WeightMetrics({super.key, required this.weight});
  final TextEditingController weight;

  @override
  State<WeightMetrics> createState() => _WeightMetricsState();
}

bool indx = true;

class _WeightMetricsState extends State<WeightMetrics> {
  double _currentDoubleValuelbs = 66.0;
  double _currentDoubleValuekg = 30.0;
  late TextEditingController weight;
  @override
  void initState() {
    weight = widget.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weight.text = _currentDoubleValuekg.toString();
    return Column(
      children: [
        const Center(
          child: Text(
            'What\'s your current Weight?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 100),
        if (indx)
          Column(
            children: <Widget>[
              DecimalNumberPicker2(
                haptics: true,
                value: _currentDoubleValuekg,
                minValue: 30,
                maxValue: 300,
                units: 'kg',
                decimalPlaces: 1,
                onChanged: (value) => setState(() {
                  _currentDoubleValuekg = value;
                  if (_currentDoubleValuekg > 299.7) {
                    _currentDoubleValuelbs = 660.9;
                  } else {
                    _currentDoubleValuelbs = _currentDoubleValuekg * 2.20462262;
                    _currentDoubleValuelbs =
                        double.parse(_currentDoubleValuelbs.toStringAsFixed(1));
                  }
                }),
              ),
            ],
          )
        else
          Column(
            children: <Widget>[
              DecimalNumberPicker2(
                haptics: true,
                value: _currentDoubleValuelbs,
                minValue: 66,
                maxValue: 660,
                units: 'lb',
                decimalPlaces: 1,
                onChanged: (value) => setState(() {
                  _currentDoubleValuelbs = value;
                  double temp = _currentDoubleValuekg;
                  if (_currentDoubleValuelbs == 66.0) {
                    _currentDoubleValuekg = 30.0;
                  } else {
                    _currentDoubleValuekg = _currentDoubleValuelbs / 2.20462262;
                    _currentDoubleValuekg =
                        double.parse(_currentDoubleValuekg.toStringAsFixed(1));
                  }
                  if (_currentDoubleValuelbs == 660.9) {
                    _currentDoubleValuekg = temp;
                  }
                }),
              ),
            ],
          ),
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.small(
              elevation: 0,
              onPressed: () {
                setState(() {
                  indx = true;
                  // double temp = _currentDoubleValuekg;
                  // if (_currentDoubleValuelbs == 66.0) {
                  //   _currentDoubleValuekg = 30.0;
                  // } else {
                  //   _currentDoubleValuekg = _currentDoubleValuelbs / 2.20462262;
                  //   _currentDoubleValuekg =
                  //       double.parse(_currentDoubleValuekg.toStringAsFixed(1));
                  // }
                  // if (_currentDoubleValuelbs == 660.9) {
                  //   _currentDoubleValuekg = temp;
                  // }
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
                  if (_currentDoubleValuekg > 299.7) {
                    _currentDoubleValuelbs = 660.9;
                  } else {
                    _currentDoubleValuelbs = _currentDoubleValuekg * 2.20462262;
                    _currentDoubleValuelbs =
                        double.parse(_currentDoubleValuelbs.toStringAsFixed(1));
                  }
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
