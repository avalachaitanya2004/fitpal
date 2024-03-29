import 'package:flutter/material.dart';

class DotProgress extends StatelessWidget {
  DotProgress({super.key, required this.TotDays, required this.DaysCompleted});
  final int TotDays;
  final int DaysCompleted;
  // late List<int> days;
  // late int i;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(TotDays, (index) {
        return Flexible(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(1),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: index < DaysCompleted
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
          ),
        );
      }),
    );
  }
}
