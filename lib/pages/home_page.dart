import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/models/bottomnavitm.dart';
import 'package:fit_pal/models/challenges.dart';
import 'package:fit_pal/models/menu.dart';
import 'package:fit_pal/pages/Faq.dart';
import 'package:fit_pal/pages/HomePages/home.dart';
import 'package:fit_pal/pages/about_us.dart';
import 'package:fit_pal/pages/challenges_page.dart';
import 'package:fit_pal/pages/feedback_page.dart';
import 'package:fit_pal/pages/leader_board.dart';
import 'package:fit_pal/pages/meals_page.dart';
import 'package:fit_pal/pages/profile_page.dart';
import 'package:fit_pal/pages/side_menu.dart';
import 'package:fit_pal/pages/streak_calendar.dart';
import 'package:fit_pal/pages/water_card.dart';
import 'package:fit_pal/pages/workout_select.dart';
import 'package:fit_pal/pages/take_photo.dart';
import 'package:fit_pal/utility/rive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';

const Color bottomnavbtnclr = Color(0xff17203a);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/preLogin');
  }

  late AnimationController _anicon;
  late Animation<double> animation;
  late Animation<double> scaleanimation;

  late AnimationController _con;
  bool isSideMenuClosed = true;
  @override
  void initState() {
    _anicon =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _anicon, curve: Curves.fastOutSlowIn));
    scaleanimation = Tween<double>(begin: 1, end: 0.8)
        .animate(CurvedAnimation(parent: _anicon, curve: Curves.fastOutSlowIn));
    // _con = AnimationController(vsync: this, duration: Duration(seconds: 1));
    // _curve = CurvedAnimation(parent: _con, curve: Curves.easeInOut);
    // _pos = Tween(begin: -0.5, end: -1.0).animate(_curve);
    super.initState();
  }

  Menu selectedBottonNav = bottomNavItems.first;
  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu && menu != bottomNavItems[2]) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  void jump(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePhoto(),
        ),
      );
    } else if (index == 1 || index == 0) {
      setState(() {
        _Page.jumpToPage(index);
      });
    } else {
      setState(() {
        _Page.jumpToPage(index - 1);
      });
    }
  }

  @override
  void dispose() {
    _anicon.dispose();
    super.dispose();
  }

  // List<bool> buttons = [true, false, false, false];
  PageController _Page = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    // _con.forward();
    return Stack(
      children: [
        Scaffold(
          // appBar: AppBar(),
          drawer: Drawer(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfilePage();
                        }));
                      },
                      leading: Icon(
                        Icons.person_outline_outlined,
                        size: 30,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LeaderBoard();
                        }));
                      },
                      leading: Icon(
                        Icons.place,
                        size: 30,
                      ),
                      title: Text(
                        'Leaderboard',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return StreakCalendar();
                        }));
                      },
                      leading: Icon(
                        CupertinoIcons.flame,
                        size: 30,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Streak',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WaterPage();
                        }));
                      },
                      leading: Icon(
                        Icons.water_drop,
                        color: Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        'Water',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FAQPage();
                        }));
                      },
                      leading: Icon(
                        Icons.group,
                        color: Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        "FAQ's",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FeedbackPage();
                        }));
                      },
                      leading: Icon(
                        Icons.group,
                        color: Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        'Feedback',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AboutUsPage();
                        }));
                      },
                      leading: Icon(
                        Icons.group,
                        color: Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        'About Us',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 34,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // backgroundColor: Color(0xFF17203A),
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: PageView(
            controller: _Page,
            onPageChanged: (int) {
              if (int == 0 || int == 1) {
                setState(() {
                  selectedBottonNav = bottomNavItems[int];
                });
              } else if (int == 2 || int == 3) {
                setState(() {
                  selectedBottonNav = bottomNavItems[int + 1];
                });
              } else {}
            },
            children: <Widget>[
              Home(),
              ChallengesPage(),
              MealsPage(),
              WorkoutSelect(),
            ],
            // physics:NeverScrollableScrollPhysics(),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.all(6.0),
          //   child: Container(
          //     height: 85,
          //     width: 85,
          //     child: FloatingActionButton(
          //       onPressed: () {
          //         // Navigator.pushNamed(context, '/takePhoto');
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => TakePhoto(),
          //           ),
          //         );
          //       },
          //       child: Icon(
          //         Icons.add,
          //         size: 35,
          //       ),
          //       shape: CircleBorder(),
          //       backgroundColor: Colors.black,
          //       foregroundColor: Colors.white,
          //     ),
          //   ),
          // ),
          // bottomNavigationBar: BottomAppBar(
          //   // notchMargin: 5.0,
          //   elevation: 25,
          //   shadowColor: Colors.grey,
          //   padding: EdgeInsets.all(5),
          //   // shape: CircularNotchedRectangle(),
          //   color: Colors.white,
          //   surfaceTintColor: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       Padding(
          //           padding: EdgeInsets.only(left: 0.0),
          //           child: CircleAvatar(
          //             backgroundColor: Colors.white,

          //             // buttons[0] ? Colors.purple[100] : Colors.white,

          //             radius: 30,
          //             child: IconButton(
          //               enableFeedback: true,
          //               // highlightColor: Colors.purple[100],
          //               onPressed: () {
          //                 setState(() {
          //                   buttons = [true, false, false, false];
          //                   _Page.jumpToPage(0);
          //                 });
          //               },
          //               icon: Icon(
          //                 Icons.home_rounded,
          //                 color: buttons[0] ? Colors.black : Colors.grey[800],
          //               ),
          //               iconSize: buttons[0] ? 35 : 30,
          //               padding:
          //                   buttons[0] ? EdgeInsets.all(10) : EdgeInsets.all(15),
          //             ),
          //           )),
          //       Padding(
          //         padding: EdgeInsets.only(left: 10.0, right: 45.0),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             CircleAvatar(
          //               backgroundColor: Colors.white,
          //               // buttons[1] ? Colors.purple[100] : Colors.white,
          //               radius: 30,
          //               child: IconButton(
          //                 enableFeedback: true,
          //                 // highlightColor: Colors.purple[100],
          //                 onPressed: () {
          //                   setState(() {
          //                     buttons = [false, true, false, false];
          //                     _Page.jumpToPage(1);
          //                   });
          //                 },
          //                 icon: Icon(
          //                   Icons.pie_chart_rounded,
          //                   color: buttons[1] ? Colors.black : Colors.grey[800],
          //                 ),
          //                 iconSize: buttons[1] ? 35 : 30,
          //                 padding:
          //                     buttons[1] ? EdgeInsets.all(10) : EdgeInsets.all(15),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       Padding(
          //           padding: EdgeInsets.only(left: 45.0),
          //           child: CircleAvatar(
          //             backgroundColor: Colors.white,
          //             // buttons[2] ? Colors.purple[100] : Colors.white,
          //             radius: 30,
          //             child: IconButton(
          //               enableFeedback: true,
          //               // highlightColor: Colors.purple[100],
          //               onPressed: () {
          //                 setState(() {
          //                   buttons = [false, false, true, false];
          //                   _Page.jumpToPage(2);
          //                 });
          //               },
          //               icon: Icon(
          //                 Icons.document_scanner_outlined,
          //                 color: buttons[2] ? Colors.black : Colors.grey[800],
          //               ),
          //               iconSize: buttons[2] ? 35 : 30,
          //               padding:
          //                   buttons[2] ? EdgeInsets.all(10) : EdgeInsets.all(15),
          //             ),
          //           )),
          //       Padding(
          //         padding: EdgeInsets.only(left: 10.0),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             CircleAvatar(
          //               backgroundColor: Colors.white,
          //               // buttons[3] ? Colors.purple[100] : Colors.white,
          //               radius: 30,
          //               child: IconButton(
          //                 enableFeedback: true,
          //                 // highlightColor: Colors.purple[100],
          //                 onPressed: () {
          //                   setState(() {
          //                     buttons = [false, false, false, true];
          //                     _Page.jumpToPage(3);
          //                   });
          //                 },
          //                 icon: Icon(
          //                   Icons.person_2_rounded,
          //                   color: buttons[3] ? Colors.black : Colors.grey[800],
          //                 ),
          //                 iconSize: buttons[3] ? 35 : 30,
          //                 padding:
          //                     buttons[3] ? EdgeInsets.all(10) : EdgeInsets.all(15),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // body: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     DatePicker(
          //       DateTime.now(),
          //       initialSelectedDate: DateTime.now(),
          //       selectionColor: Colors.black,
          //       selectedTextColor: Colors.white,
          //       onDateChange: (date) {
          //         // New date selected
          //         setState(() {
          //           // _selectedValue = date;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          // body: AnimatedContainer(
          //   duration: Duration(seconds: 1),
          //   height: double.maxFinite,
          //   width: double.maxFinite,
          //   decoration: BoxDecoration(
          //       gradient: RadialGradient(
          //     radius: 1.5,
          //     // center: Alignment(0, _pos.value),
          //     center: Alignment(0, -1),
          //     // radius:0.5,
          //     colors: [Color.fromARGB(255, 69, 75, 232), Colors.white],
          //     stops: [0.0, 1.0],
          //   )),
          //   // color: Colors.blue,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
          //         child: DatePicker(
          //           DateTime.now(),
          //           initialSelectedDate: DateTime.now(),
          //           selectionColor: Colors.black,
          //           selectedTextColor: Colors.white,
          //           onDateChange: (date) {
          //             // New date selected
          //             setState(() {
          //               // _selectedValue = date;
          //             });
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Transform.translate(
            offset: Offset(0, 100 * animation.value),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: bottomnavbtnclr.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: bottomnavbtnclr.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    bottomNavItems.length,
                    (index) {
                      Menu navBar = bottomNavItems[index];
                      if (index == 2)
                        return Container(
                          // height: 20,
                          // width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white.withOpacity(0.35)),
                          child: BtmNavItem(
                            navBar: navBar,
                            press: () {
                              RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                              updateSelectedBtmNav(navBar);
                              jump(index);
                            },
                            riveOnInit: (artboard) {
                              navBar.rive.status = RiveUtils.getRiveInput(
                                  artboard,
                                  stateMachineName:
                                      navBar.rive.stateMachineName);
                            },
                            selectedNav: selectedBottonNav,
                          ),
                        );
                      else
                        return BtmNavItem(
                          navBar: navBar,
                          press: () {
                            RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                            updateSelectedBtmNav(navBar);
                            jump(index);
                          },
                          riveOnInit: (artboard) {
                            navBar.rive.status = RiveUtils.getRiveInput(
                                artboard,
                                stateMachineName: navBar.rive.stateMachineName);
                          },
                          selectedNav: selectedBottonNav,
                        );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
