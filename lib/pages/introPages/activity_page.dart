import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.activity});
  final TextEditingController activity;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late TextEditingController activities;
  @override
  void initState() {
    activities = widget.activity;
    super.initState();
  }

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
  final List<bool> isSelected = <bool>[true, false, false, false];
  @override
  Widget build(BuildContext context) {
    int i;
    for (i = 0; i < 4; i++) {
      if (isSelected[i]) {
        activities.text = i.toString();
        break;
      }
    }
    return Column(
      children: [
        const Center(
            child: Text(
          'How active are you?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(10),
          height: 400,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: activity.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected[index] ? Border.all() : const Border(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                height: 80,
                child: ListTile(
                  onTap: () {
                    setState(
                      () {
                        isSelected[index] = true;
                        isSelected[(index + 1) % 4] = false;
                        isSelected[(index + 2) % 4] = false;
                        isSelected[(index + 3) % 4] = false;
                      },
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(211, 215, 215, 215),
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
        ),
      ],
    );
  }
}
