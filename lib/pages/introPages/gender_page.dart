import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final List<String> gender = <String>[
    'Male',
    'Female',
  ];
  final List<IconData> icon = <IconData>[
    Icons.male_rounded,
    Icons.female_rounded,
  ];
  final List<bool> isSelected = <bool>[false, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
            child: Text(
          'How active are you?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const SizedBox(height: 40),
        SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(gender.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      isSelected[index] = true;
                      isSelected[(index + 1) % 2] = false;
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected[index] ? Border.all() : const Border(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 150,
                  width: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor:
                            const Color.fromARGB(211, 215, 215, 215),
                        child: Icon(
                          icon[index],
                          color: Colors.black,
                          size: 60,
                        ),
                      ),
                      Text(
                        gender[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
