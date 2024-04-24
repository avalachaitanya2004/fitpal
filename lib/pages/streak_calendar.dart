// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StreakCalendar extends StatefulWidget {
  const StreakCalendar({super.key});

  @override
  State<StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<StreakCalendar> {
  DateTime _focusedDay = DateTime.now();
  List<DateTime> dates = [
    DateTime.utc(2024, 3, 1),
    DateTime.utc(2024, 3, 2),
    DateTime.utc(2024, 3, 3),
    DateTime.utc(2024, 3, 9),
    DateTime.utc(2024, 3, 10),
    DateTime.utc(2024, 3, 16),
    DateTime.utc(2024, 3, 17),
    DateTime.utc(2024, 3, 23),
    DateTime.utc(2024, 3, 24),
    DateTime.utc(2024, 3, 30),
    DateTime.utc(2024, 3, 31),
    DateTime.utc(2024, 4, 6),
    DateTime.utc(2024, 4, 16),
    DateTime.utc(2024, 4, 15),
    DateTime.utc(2024, 4, 14),
    DateTime.utc(2024, 4, 12),
    DateTime.utc(2024, 4, 10),
    DateTime.utc(2024, 4, 18),
    DateTime.utc(2024, 4, 17),
    DateTime.utc(2024, 4, 20),
    DateTime.utc(2024, 4, 21),
    DateTime.utc(2024, 4, 22),
  ];
  bool _isInAnyRange(DateTime day) => dates.contains(day);

  static bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    int streak = calculateCurrentStreak();
  }

  int calculateCurrentStreak() {
    List<DateTime> normalizedDates =
        dates.map((date) => DateTime(date.year, date.month, date.day)).toList();
    normalizedDates.sort((a, b) => b.compareTo(a));
    DateTime today = DateTime.now();
    DateTime normalizedToday = DateTime(today.year, today.month, today.day);
    int currentStreak = 0;
    DateTime previousDate = normalizedToday.subtract(const Duration(days: 1));
    for (int i = 0; i < normalizedDates.length; i++) {
      if (normalizedDates.contains(previousDate)) {
        currentStreak++;
        previousDate = previousDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return normalizedDates.contains(normalizedToday)
        ? currentStreak + 1
        : currentStreak;
  }

  int streak = 0;

  @override
  Widget build(BuildContext context) {
    streak = calculateCurrentStreak();
    if (isCompleted) {
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if (!dates.any((date) =>
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day)) {
        dates.add(today);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.4),
            child: Icon(Icons.close, color: Colors.black),
          ),
        ),
        centerTitle: true,
        title: Text('Streak',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        CupertinoIcons.flame,
                        color: Colors.orange,
                        size: 100,
                      ),
                      Column(
                        children: [
                          Text(
                            ' $streak',
                            style: TextStyle(
                              height: 0.8,
                              // fontFamily: 'Bebas_Neue',
                              letterSpacing: -10,
                              fontSize: 80,
                              color: Colors.black.withOpacity(0.7),
                              // backgroundColor: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'day streak!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 10),
                    child: TableCalendar(
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      onDaySelected: (selectedDay, focusedDay) {},
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 247, 194),
                            shape: BoxShape.circle),
                        selectedTextStyle: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.bold),
                        todayTextStyle: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.bold),
                        todayDecoration: BoxDecoration(
                            color: isCompleted
                                ? Color.fromARGB(255, 222, 247, 194)
                                : Colors.grey[300],
                            shape: BoxShape.circle),
                      ),
                      selectedDayPredicate: (day) => _isInAnyRange(day),
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






  // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Edit Profile"),
    //     backgroundColor: Colors.white,
    //     surfaceTintColor: Colors.white,
    //     leading: GestureDetector(
    //       onTap: () => Navigator.pop(context),
    //       child: CircleAvatar(
    //         backgroundColor: Colors.white.withOpacity(0.4),
    //         child: Icon(Icons.arrow_back, color: Colors.black),
    //       ),
    //     ),
    //   ),
    // body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text("data"),
    //       SizedBox(height: 10),
    //       Text(start?.toIso8601String() ?? "-"),
    //       Text("to"),
    //       Text(end?.toIso8601String() ?? "-"),
    //       SizedBox(height: 16),
    //       Padding(
    //         padding: EdgeInsets.all(24),
    //         child: ElevatedButton(
    //           child: Text("Date Range Picker"),
    //           onPressed: () {
    //             showDateRangePicker(
    //               context: context,
    //               firstDate: DateTime(2000),
    //               lastDate: DateTime.now().add(
    //                 const Duration(days: 356),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // body: TableCalendar(
    //   firstDay: DateTime.utc(2010, 10, 16),
    //   lastDay: DateTime.utc(2030, 3, 14),
    //   focusedDay: _focusedDay,
    //   selectedDayPredicate: (day) {
    //     // Use `selectedDayPredicate` to determine which day is currently selected.
    //     // If this returns true, then `day` will be marked as selected.
    //     return isSameDay(_selectedDay, day);
    //   },
    //   onDaySelected: (selectedDay, focusedDay) {
    //     setState(() {
    //       _selectedDay = selectedDay;
    //       _focusedDay =
    //           focusedDay; // update `_focusedDay` here to change the calendar's focused day
    //     });
    //   },
    //   onPageChanged: (focusedDay) {
    //     // No need to call `setState()` here unless you want to perform additional logic
    //     _focusedDay = focusedDay;
    //   },
    // ),
    // );