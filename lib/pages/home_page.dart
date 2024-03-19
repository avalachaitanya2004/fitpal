import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/preLogin');
  }

  List<bool> buttons = [true, false, false, false];
  PageController _Page = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        leading:
            GestureDetector(onTap: logout, child: Icon(Icons.logout_rounded)),
      ),
      body: PageView(
        controller: _Page,
        onPageChanged: (int) {
          print('Page Changes to index $int');
        },
        children: <Widget>[
          Center(
            child: Container(
              child: Text('Empty Body 0'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 1'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 2'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 3'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 4'),
            ),
          )
        ],
        physics:
            NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 85,
          width: 85,
          child: FloatingActionButton(
            splashColor: Colors.purple[100],
            onPressed: () {
              setState(() {
                _Page.jumpToPage(4);
              });
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
                  backgroundColor:
                      buttons[0] ? Colors.purple[100] : Colors.white,
                  radius: 30,
                  child: IconButton(
                    enableFeedback: true,
                    highlightColor: Colors.purple[100],
                    onPressed: () {
                      setState(() {
                        buttons = [true, false, false, false];
                        _Page.jumpToPage(0);
                      });
                    },
                    icon: Icon(
                      Icons.home_rounded,
                      color: buttons[0] ? Colors.white : Colors.grey[800],
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
                    backgroundColor:
                        buttons[1] ? Colors.purple[100] : Colors.white,
                    radius: 30,
                    child: IconButton(
                      enableFeedback: true,
                      highlightColor: Colors.purple[100],
                      onPressed: () {
                        setState(() {
                          buttons = [false, true, false, false];
                          _Page.jumpToPage(1);
                        });
                      },
                      icon: Icon(
                        Icons.pie_chart_rounded,
                        color: buttons[1] ? Colors.white : Colors.grey[800],
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
                  backgroundColor:
                      buttons[2] ? Colors.purple[100] : Colors.white,
                  radius: 30,
                  child: IconButton(
                    enableFeedback: true,
                    highlightColor: Colors.purple[100],
                    onPressed: () {
                      setState(() {
                        buttons = [false, false, true, false];
                        _Page.jumpToPage(2);
                      });
                    },
                    icon: Icon(
                      Icons.document_scanner_outlined,
                      color: buttons[2] ? Colors.white : Colors.grey[800],
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
                    backgroundColor:
                        buttons[3] ? Colors.purple[100] : Colors.white,
                    radius: 30,
                    child: IconButton(
                      enableFeedback: true,
                      highlightColor: Colors.purple[100],
                      onPressed: () {
                        setState(() {
                          buttons = [false, false, false, true];
                          _Page.jumpToPage(3);
                        });
                      },
                      icon: Icon(
                        Icons.person_2_rounded,
                        color: buttons[3] ? Colors.white : Colors.grey[800],
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
    );
  }
}
