import 'package:bounce_tap/bounce_tap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/Profileimage.dart';
import 'package:fit_pal/pages/edit_profile.dart';
import 'package:fit_pal/pages/friend_search_page.dart';
import 'package:fit_pal/pages/pre_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Dataservices dataservices;
  String name = '';
  String email = '';
  double weight = 0.0;
  int height = 0;
  bool nameload = false;
  String link = '';
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    // String? uid = AuthService.getUID();
    String uid = user!.uid;
    if (uid != null) {
      dataservices = Dataservices(uid: uid);
      dataservices.getUserInfo().then((userInfo) {
        setState(() {
          name = userInfo['name'] ?? '';
          email = userInfo['email'] ?? '';
          weight = userInfo['weight'] ?? '';
          height = userInfo['height'] ?? '';
          nameload = true;
        });
      });
    } else {
      print("uid is null");
    }
    Getlink();
  }

  void Getlink() async {
    Profilepage profilepage =
        Profilepage(uid: FirebaseAuth.instance.currentUser!.uid);
    String? hii = await profilepage.getProfileLink();
    if (hii != null) {
      link = hii;
    }
  }

  Widget buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(link),
          radius: 60,
        ),
        const SizedBox(height: 20),
        nameload
            ? Text(name, //NAME
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            : SizedBox(
                width: 140,
                height: 40,
                child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Color.fromARGB(255, 232, 231, 231),
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 20,
                            width: 130,
                            color: Colors.black,
                          );
                        })),
              ),
        Text(email, //EMAIL
            style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget buildAction(String title, IconData icon, Function() onTap) {
    return BounceTap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget buildStatsCard(
      String title, String value, IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        buildStatsCard('Total XP', '230', Icons.bolt, Colors.amber),
        buildStatsCard('Streak', '12', CupertinoIcons.flame, Colors.red),
        buildStatsCard(
            'Weight', weight.toString(), Icons.settings, Colors.blue),
        buildStatsCard('Height', height.toString(), Icons.update, Colors.green),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Are you sure you want to exit?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
                      icon: Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 36,
                      ),
                      content: Container(
                        height: 160,
                        child: Column(
                          children: [
                            Text(
                              "Sure you want to Logout",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                _signOut();
                              },
                              child: Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Center(
                                  child: Text(
                                    'cancel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.logout)),
        ],
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildHeader(),
            const SizedBox(height: 30),
            buildAction('Edit Profile', Icons.edit, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => EditProfile()));
            }),
            const SizedBox(height: 20),
            buildStatsGrid(),
            const SizedBox(height: 20),
            buildAction('Add Friends', Icons.person_add_outlined, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FriendSearch()));
            }),
          ],
        ),
      ),
    );
  }
}
