import 'package:fit_pal/utility/GlassMorphism.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class SegmentedControl extends StatefulWidget {
//   const SegmentedControl({super.key});

//   @override
//   State<SegmentedControl> createState() => _SegmentedControlState();
// }

// class _SegmentedControlState extends State<SegmentedControl> {
//   String? _currentText;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           CupertinoSegmentedControl(
//             padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//             borderColor: Colors.transparent,
//             selectedColor: CupertinoColors.lightBackgroundGray,
//             children: {
//               "Meals": Container(
//                 decoration: BoxDecoration(
//                   // color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                 child: Text("Meals"),
//               ),
//               "Activity": Container(
//                 decoration: BoxDecoration(
//                   color: CupertinoColors.lightBackgroundGray,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                 child: Text("Meals"),
//               ),
//               "Water": Container(
//                 decoration: BoxDecoration(
//                   color: CupertinoColors.lightBackgroundGray,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                 child: Text("Meals"),
//               ),
//             },
//             onValueChanged: (String value) {
//               setState(() {
//                 _currentText = value;
//               });
//             },
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           _currentText != null ? Text("data $_currentText") : Container(),
//         ],
//       ),
//     );
//   }
// }

class SegmentedControl extends StatefulWidget {
  const SegmentedControl({super.key});

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  final List<String> activity = <String>[
    'Little or No Activity',
    'Lightly Active',
    'Moderately Active',
    'Very Active'
  ];
  final List<String> activityDescription = <String>[
    'Mostly sitting through the day(eg. Desk Job,Bank Teller)',
    'Mostly standing through the day(eg. Sales Associate,Teacher)',
    'Mostly walking or doing physical activities through the day(eg. Tour Guide,Waiter)',
    'Mostly doing heavy physical activities through the day(eg. Gym Instructor,Construction Worker)'
  ];
  final List<IconData> icon = <IconData>[
    Icons.chair_alt_outlined,
    Icons.man_3_rounded,
    Icons.directions_walk_rounded,
    Icons.sports_gymnastics_rounded,
  ];
  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl<int>(
              backgroundColor: Color.fromARGB(121, 239, 239, 239),
              padding: EdgeInsets.all(4),
              groupValue: groupValue,
              children: {
                0: Container(
                  // decoration:
                  // BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Meals",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            groupValue == 0 ? Colors.black : Colors.grey[400]),
                  ),
                ),
                1: Container(
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Activity",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            groupValue == 1 ? Colors.black : Colors.grey[400]),
                  ),
                ),
                2: Container(
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Water",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            groupValue == 2 ? Colors.black : Colors.grey[400]),
                  ),
                ),
              },
              onValueChanged: (groupValue) {
                setState(() {
                  this.groupValue = groupValue;
                });
              },
            ),
            groupValue != null
                ? Container(
                    padding: const EdgeInsets.all(10),
                    height: 350,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: activity.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color.fromARGB(255, 206, 189, 240),
                                Colors.white,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: const Border(),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          height: 150,
                          child: ListTile(
                            onTap: () {
                              setState(
                                () {
                                  print("hello");
                                },
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(211, 215, 215, 215),
                              child: Icon(
                                icon[index],
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                            title: Text(
                              activity[index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              activityDescription[index],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
