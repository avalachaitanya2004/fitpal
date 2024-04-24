import 'dart:async';

import 'package:fit_pal/models/challenges.dart';
import 'package:fit_pal/utility/dot_progress.dart';
import 'package:fit_pal/utility/friend_challenge_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_stack/image_stack.dart';

class ChallengesCard extends StatefulWidget {
  const ChallengesCard(
      {super.key, required this.isTapped, required this.challenge});
  final bool isTapped;
  final Challenges challenge;

  @override
  State<ChallengesCard> createState() => _ChallengesCardState();
}

class _ChallengesCardState extends State<ChallengesCard>
    with TickerProviderStateMixin {
  late AnimationController _con;
  late Animation<double> _ani;
  @override
  void initState() {
    _con =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _ani = Tween<double>(begin: 0.4, end: 1).animate(_con);

    super.initState();
  }

  int st = 0;

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }

  @override
  bool helo = false;
  bool isTapped = false;
  late Challenges challenge;
  Widget build(BuildContext context) {
    challenge = widget.challenge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          // if (!isTapped) {
          //   _con.forward();
          // } else {
          //   _con.reverse();
          // }
          if (helo) {
            setState(() {
              isTapped = !isTapped;
              helo = !helo;
            });
          } else {
            setState(() {
              isTapped = !isTapped;
            });
            Future.delayed(const Duration(milliseconds: 250), () {
              // isTapped = !isTapped;
              setState(() {
                // isTapped = !isTapped;
                helo = !helo;
              });
            });
          }
          // Timer(Duration(milliseconds: 500), () {
          //   setState(() {
          //     isTapped = !isTapped;
          //   });
          // });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(245, 202, 201, 255),
          ),
          margin: EdgeInsets.all(10),
          height: isTapped ? 500 : 200,
          width: double.infinity,
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        challenge.type,
                        style: TextStyle(
                            fontSize: 16, color: Colors.black.withOpacity(0.7)),
                      ),
                      // Spacer(),
                      // ImageStack(
                      //     // imageSource: ImageSource.File,
                      //     imageList: [
                      //       'assets/images/profile_demo.jpeg',
                      //       'assets/images/profile_demo.jpeg',
                      //       'assets/images/profile_demo.jpeg',
                      //     ],
                      //     totalCount: 3)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          challenge.title,
                          style: TextStyle(
                            fontSize: 42,
                            height: 1.15,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isTapped)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          // color: Colors.blue,
                          child: Column(
                            children: List.generate(
                              7,
                              (index) => FriendProgress(
                                  percent: 0.5,
                                  profile: 'assets/images/profile_demo.jpeg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (helo)
                  AnimatedOpacity(
                    opacity: isTapped ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: (st == 1)
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(245, 175, 173, 241),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // padding: EdgeInsets.all(0),
                              width: double.infinity,

                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10, right: 10, bottom: 10),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your progress',
                                      style: TextStyle(fontSize: 16
                                          // backgroundColor: Colors.white,
                                          ),
                                      // textAlign: TextAlign.left,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '24 Days ',
                                          style: TextStyle(
                                              fontSize: 40, height: 1),
                                        ),
                                        Text(
                                          'Left',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    //progress bar
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DotProgress(TotDays: 15, DaysCompleted: 5),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Text('32% done'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Start Challenge',
                                    style: TextStyle(fontSize: 26),
                                  ))),
                            ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                  child: Text('${challenge.duration} days'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
