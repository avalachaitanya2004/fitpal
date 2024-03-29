import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FriendProgress extends StatelessWidget {
  const FriendProgress(
      {super.key, required this.percent, required this.profile});
  final double percent;
  final String profile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            // dp

            LinearPercentIndicator(
              leading: CircleAvatar(
                backgroundImage: AssetImage(profile),
              ),
              trailing: Text('${percent * 100}%'),
              lineHeight: 10,
              width: 250,
              percent: percent,
              backgroundColor: Colors.grey[300],
              progressColor: Color.fromARGB(245, 175, 173, 241),
              barRadius: Radius.circular(10),
            ),

            //progress

            // percentage
          ],
        ),
      ),
    );
  }
}
