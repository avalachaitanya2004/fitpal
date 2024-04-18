import 'package:bounce_tap/bounce_tap.dart';
import 'package:fit_pal/pages/friend_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'John Jacobs',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'johnjacobs@gmail.com',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 40,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Overview',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey,
                            border: Border.all(color: Colors.grey, width: 2)),
                        margin: EdgeInsets.all(10),
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.bolt,
                                  size: 30,
                                  color: Colors.yellow,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '4827',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text('Total XP',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey,
                            border: Border.all(color: Colors.grey, width: 2)),
                        margin: EdgeInsets.all(10),
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.flame,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '177',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text('Day Streak',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: BounceTap(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  height: 50,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendSearch()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add_outlined),
                        Text(
                          'Add Friends',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Metrics',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey,
                            border: Border.all(color: Colors.grey, width: 2)),
                        margin: EdgeInsets.all(10),
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.bolt,
                                  size: 30,
                                  color: Colors.yellow,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '4827',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text('Height',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey,
                            border: Border.all(color: Colors.grey, width: 2)),
                        margin: EdgeInsets.all(10),
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.flame,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '177',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text('Weight',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.6))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
