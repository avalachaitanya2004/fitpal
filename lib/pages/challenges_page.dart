import 'package:fit_pal/models/challenges.dart';
import 'package:fit_pal/models/challenges_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<bool> fields = [true, false, false, false, false];
  List<Challenges> challenges = [
    Challenges('Apricot Month', 10, 'Food', 0, 0),
    Challenges('Yoga Morning', 20, 'Workout', 1, 10),
    Challenges('Yoga Morning', 20, 'Workout', 1, 10),
  ];
  String findField(int e) {
    if (e == 0) {
      return 'All';
    } else {
      if (e == 1) {
        return 'Upcoming';
      } else {
        if (e == 2) {
          return 'Ongoing';
        } else {
          if (e == 3) {
            return 'Workouts';
          } else {
            if (e == 4) {
              return 'Foods';
            } else {
              return 'None';
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        // color: Colors.blue,
        // height: double.infinity,
        // width: double.infinity,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fitness',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 44,
                              height: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Challenges',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 44,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            collapsedHeight: null,
            toolbarHeight: 125,
            expandedHeight: 150,
            elevation: 0,
            pinned: true,
            centerTitle: false,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(-10.0), child: SizedBox()),
            flexibleSpace: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    ...[
                      0,
                      1,
                      2,
                      3,
                      4,
                    ].map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (e != 0) {
                                if (fields[e]) {
                                  fields[e] = !fields[e];
                                } else {
                                  fields[e] = !fields[e];
                                  fields[0] = false;
                                }
                              } else {
                                if (!fields[0]) {
                                  fields[0] = !fields[0];
                                  int i;
                                  for (i = 1; i <= 4; i++) {
                                    fields[i] = false;
                                  }
                                } else {
                                  fields[0] = !fields[0];
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: fields[e] ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                // color: Colors.blue,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1)),
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(
                                  child: Text(
                                findField(e),
                                style: TextStyle(
                                    color: !fields[e]
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              )),
                            ),
                          ),
                        )),
                  ],
                )),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) => ChallengesCard(
                    isTapped: false, challenge: challenges[index]),
                childCount: challenges.length),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 76,
            ),
          )
        ],
      ),
    );
  }
}
