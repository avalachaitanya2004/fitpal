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
import 'package:fit_pal/pages/pre_login.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // Navigate to login or home screen after successful logout
      // Example:
      // Navigator.of(context).pushReplacementNamed('/login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PreLogin();
      }));
    } catch (e) {
      // Handle logout errors
      print('Error logging out: $e');
    }
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
  var drawerSel = false;
  @override
  Widget build(BuildContext context) {
    // _con.forward();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  drawerSel = !drawerSel;
                });
              },
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.menu, color: Colors.black),
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
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
          ),
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
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.20)),
                          child: BtmNavItem2(
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
        drawerSel
            ? Material(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(15, 65, 0, 20),
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            },
                            leading:
                                Icon(Icons.person_outline_outlined, size: 30),
                            title:
                                Text('Profile', style: TextStyle(fontSize: 18)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LeaderBoard()));
                            },
                            leading: Icon(Icons.place, size: 30),
                            title: Text('Leaderboard',
                                style: TextStyle(fontSize: 18)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StreakCalendar()));
                            },
                            leading: Icon(CupertinoIcons.flame,
                                size: 30, color: Colors.red),
                            title:
                                Text('Streak', style: TextStyle(fontSize: 18)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaterPage()));
                            },
                            leading: Icon(Icons.water_drop,
                                color: Colors.blue, size: 30),
                            title:
                                Text('Water', style: TextStyle(fontSize: 18)),
                          ),
                          Spacer(),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FAQPage()));
                            },
                            leading: Icon(Icons.help_outline,
                                color: Colors.blue, size: 30),
                            title:
                                Text("FAQ's", style: TextStyle(fontSize: 18)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedbackPage()));
                            },
                            leading: Icon(Icons.feedback,
                                color: Colors.blue, size: 30),
                            title: Text('Feedback',
                                style: TextStyle(fontSize: 18)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutUsPage()));
                            },
                            leading: Icon(Icons.info_outline,
                                color: Colors.blue, size: 30),
                            title: Text('About Us',
                                style: TextStyle(fontSize: 18)),
                          ),
                          GestureDetector(
                            onTap: _signOut,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: Icon(Icons.logout,
                                  color: Colors.red, size: 34),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 40,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          drawerSel = false;
                        }),
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
