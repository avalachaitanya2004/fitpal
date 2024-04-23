import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IntervalPage extends StatefulWidget {
  const IntervalPage({super.key, required this.nextpage});
  final VoidCallback nextpage;

  @override
  State<IntervalPage> createState() => _IntervalPageState();
}

class _IntervalPageState extends State<IntervalPage> {
  int time = 20;
  late VoidCallback nextpage;
  late Timer _timer;
  bool isrun = false;
  void startTimer() {
    setState(() {
      isrun = true;
    });
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        if (time == 0) {
          setState(() {
            timer.cancel();
            isrun = false;
          });
          nextpage();
          Navigator.pop(context);
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    nextpage = widget.nextpage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularPercentIndicator(
              animation: true,
              animateFromLastPercent: true,
              radius: 150.0,
              lineWidth: 20.0,
              percent: (time / 20),
              center: Text(
                '${time}',
                style: TextStyle(fontSize: 100),
              ),
              progressColor: Colors.green,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (isrun) {
                    _timer.cancel();
                    setState(() {
                      isrun = false;
                    });
                  } else {
                    setState(() {
                      isrun = true;
                      startTimer();
                    });
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: isrun
                      ? Icon(
                          Icons.pause,
                          size: 36,
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: 36,
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _timer.cancel();
                  nextpage();
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.skip_next,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
