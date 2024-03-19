/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'dart:ui';

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final bool is_selected;

  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
    required this.is_selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        child: BackdropFilter(
          filter: is_selected
              ? ImageFilter.blur(sigmaX: 50, sigmaY: 50)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            // height: 100,
            width: width,
            margin: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              // color: selectionColor,
              color: is_selected
                  ? Colors.white.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child:
                // padding: EdgeInsets.all(8),
                Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                // bottom: 8,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    new DateFormat("E", locale)
                        .format(date)
                        .toUpperCase()
                        .substring(0, 1), // WeekDay
                    // style: dayTextStyle
                    style: TextStyle(
                        // backgroundColor: Colors.blue,
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text('hi'),
                  // Text(
                  //     new DateFormat("MMM", locale)
                  //         .format(date)
                  //         .toUpperCase(), // Month
                  //     style: monthTextStyle),
                  Text(
                    date.day.toString(), // Date
                    // style: dateTextStyle
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      // backgroundColor: Colors.blue,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
