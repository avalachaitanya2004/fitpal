import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/models/challenges.dart';
import 'package:fit_pal/pages/HomePages/home.dart';
import 'package:fit_pal/pages/challenges_page.dart';
import 'package:fit_pal/pages/meals_page.dart';
import 'package:fit_pal/pages/side_menu.dart';
import 'package:fit_pal/pages/take_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';

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

  // late Animation<double> _pos;
  // late Animation<double> _curve;
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

  List<bool> buttons = [true, false, false, false];
  PageController _Page = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    // _con.forward();
    return Scaffold(
      // backgroundColor: Color(0xFF17203A),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // title: Text('Home Page'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white, // You can set the border color here
                width: 1.0, // You can set the border width here
              ),
            ),
            child: GestureDetector(
              onTap: () {
                // if (isSideMenuClosed) {
                //   _anicon.forward();
                // } else {
                //   _anicon.reverse();
                // }
                // setState(() {
                //   isSideMenuClosed = !isSideMenuClosed;
                // });
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/default_pic.jpeg'),
              ),
            ),
          ),
        ),
        // GestureDetector(onTap: logout, child: Icon(Icons.logout_rounded)),
      ),
      body: PageView(
        controller: _Page,
        onPageChanged: (int) {
          // print('Page Changes to index $int');
        },
        children: <Widget>[
          Home(),
          ChallengesPage(),
          MealsPage(),
          Center(
            child: Container(
              child: Text('Empty Body 3'),
            ),
          ),
        ],
        // physics:NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 85,
          width: 85,
          child: FloatingActionButton(
            // splashColor: Colors.purple[100],
            onPressed: () {
              // setState(() {
              //   _Page.jumpToPage(4);
              // });
              // Navigator.pushNamed(context, '/takePhoto');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePhoto(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 35,
            ),
            shape: CircleBorder(),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // notchMargin: 5.0,
        elevation: 25,
        shadowColor: Colors.grey,
        padding: EdgeInsets.all(5),
        // shape: CircularNotchedRectangle(),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,

                  // buttons[0] ? Colors.purple[100] : Colors.white,

                  radius: 30,
                  child: IconButton(
                    enableFeedback: true,
                    // highlightColor: Colors.purple[100],
                    onPressed: () {
                      setState(() {
                        buttons = [true, false, false, false];
                        _Page.jumpToPage(0);
                      });
                    },
                    icon: Icon(
                      Icons.home_rounded,
                      color: buttons[0] ? Colors.black : Colors.grey[800],
                    ),
                    iconSize: buttons[0] ? 35 : 30,
                    padding:
                        buttons[0] ? EdgeInsets.all(10) : EdgeInsets.all(15),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 45.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    // buttons[1] ? Colors.purple[100] : Colors.white,
                    radius: 30,
                    child: IconButton(
                      enableFeedback: true,
                      // highlightColor: Colors.purple[100],
                      onPressed: () {
                        setState(() {
                          buttons = [false, true, false, false];
                          _Page.jumpToPage(1);
                        });
                      },
                      icon: Icon(
                        Icons.pie_chart_rounded,
                        color: buttons[1] ? Colors.black : Colors.grey[800],
                      ),
                      iconSize: buttons[1] ? 35 : 30,
                      padding:
                          buttons[1] ? EdgeInsets.all(10) : EdgeInsets.all(15),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 45.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  // buttons[2] ? Colors.purple[100] : Colors.white,
                  radius: 30,
                  child: IconButton(
                    enableFeedback: true,
                    // highlightColor: Colors.purple[100],
                    onPressed: () {
                      setState(() {
                        buttons = [false, false, true, false];
                        _Page.jumpToPage(2);
                      });
                    },
                    icon: Icon(
                      Icons.document_scanner_outlined,
                      color: buttons[2] ? Colors.black : Colors.grey[800],
                    ),
                    iconSize: buttons[2] ? 35 : 30,
                    padding:
                        buttons[2] ? EdgeInsets.all(10) : EdgeInsets.all(15),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    // buttons[3] ? Colors.purple[100] : Colors.white,
                    radius: 30,
                    child: IconButton(
                      enableFeedback: true,
                      // highlightColor: Colors.purple[100],
                      onPressed: () {
                        setState(() {
                          buttons = [false, false, false, true];
                          _Page.jumpToPage(3);
                        });
                      },
                      icon: Icon(
                        Icons.person_2_rounded,
                        color: buttons[3] ? Colors.black : Colors.grey[800],
                      ),
                      iconSize: buttons[3] ? 35 : 30,
                      padding:
                          buttons[3] ? EdgeInsets.all(10) : EdgeInsets.all(15),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
    );
  }
}
