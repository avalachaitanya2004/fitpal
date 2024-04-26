import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataFriends/getfriends.dart';
import 'package:fit_pal/Profileimage.dart';
import 'package:fit_pal/pages/friend_search_page.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class CustomUser2 {
  final String name;
  final String email;
  final int XP;
  final int streak;
  final String imageUrl;

  CustomUser2({
    required this.name,
    required this.email,
    required this.XP,
    required this.streak,
    required this.imageUrl,
  });
}

class _LeaderBoardState extends State<LeaderBoard> {
  String name = '';
  String email = '';
  int XP = 0;
  int streak = 0;
  String imageUrl = '';
  Future<int> getCurrentWeekXP() async {
    // Get the start and end dates for the current week
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user!.uid;
    final firestoreInstance = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month,
        now.day - now.weekday + 1); // Start date of the current week (Monday)
    DateTime endDate = startDate
        .add(Duration(days: 6)); // End date of the current week (Sunday)

    // Query Firestore for XP within the current week's range
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestoreInstance.collection('XP').doc(userId).get();

    // Initialize a map to store XP for each date in the current week
    Map<String, int> currentWeekXP = {};

    // Extract data from the document snapshot
    Map<String, dynamic> data = documentSnapshot.data()!;

    // Iterate over the data
    data.forEach((key, value) {
      DateTime date = DateTime.parse(key);
      // Check if the date is within the current week's range
      if (date.isAfter(startDate.subtract(Duration(days: 1))) &&
          date.isBefore(endDate.add(Duration(days: 1)))) {
        currentWeekXP[key] = value;
      }
    });
    int s = 0;

    DateTime date2 = DateTime.now();
    String dateString = date2.toIso8601String().substring(0, 10);
    currentWeekXP.forEach((date, xp) {
      if (dateString == date) {
        print("yes");
        setState(() {
          // todayXP = xp;
        });
      }
      s += xp;
    });
    setState(() {
      // weekXP = s;
      XP = s;
    });

    return s;
  }

  List<String> foundFriends = [];

  List<CustomUser2> usersfriends = [];

  // Future<int> getTotalXP(String userId) async {
  //   // Get the start and end dates for the current week
  //   final firestoreInstance = FirebaseFirestore.instance;
  //   DateTime now = DateTime.now();
  //   DateTime startDate = DateTime(now.year, now.month,
  //       now.day - now.weekday + 1); // Start date of the current week (Monday)
  //   DateTime endDate = startDate
  //       .add(Duration(days: 6)); // End date of the current week (Sunday)

  //   // Query Firestore for XP within the current week's range
  //   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  //       await firestoreInstance.collection('XP').doc(userId).get();

  //   // Initialize a map to store XP for each date in the current week
  //   Map<String, int> currentWeekXP = {};

  //   // Extract data from the document snapshot
  //   Map<String, dynamic> data = documentSnapshot.data()!;
  //   int sum = 0;
  //   // Iterate over the data
  //   data.forEach((key, value) {
  //     // Check if the date is within the current week's range
  //     sum += value as int;
  //     currentWeekXP[key] = value;
  //   });
  //   int s = 0;

  //   DateTime date2 = DateTime.now();
  //   String dateString = date2.toIso8601String().substring(0, 10);
  //   currentWeekXP.forEach((date, xp) {
  //     if (dateString == date) {
  //       print("yes");
  //       setState(() {
  //         // todayXP = xp;
  //       });
  //     }
  //     s += xp;
  //   });
  //   setState(() {
  //     // weekXP = s;
  //   });

  //   return sum;
  // }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    UserData userData = UserData(uid: uid, statusMap: {});
    foundFriends = await userData.getUserIdsWithStatusF();
    for (int i = 0; i < foundFriends.length; i++) {
      String uid1 = foundFriends[i];
      Profilepage profilepage = Profilepage(uid: uid1);
      String? link = await profilepage.getProfileLink();
      Dataservices dataservices = Dataservices(uid: uid1);
      Map<String, dynamic> userinfo1 = await dataservices.getUserInfo();
      // int XP1 = await getTotalXP(uid1);
      usersfriends.add(
        CustomUser2(
            name: userinfo1['name'],
            email: userinfo1['email'],
            XP: (7 * i + 5) * 10,
            streak: 5 + i,
            imageUrl: link.toString()),
      );
    }
    Profilepage profilepage = Profilepage(uid: uid);
    String? link = await profilepage.getProfileLink();
    Dataservices dataservices = Dataservices(uid: uid);
    Map<String, dynamic> userinfo1 = await dataservices.getUserInfo();
    name = userinfo1['name'];
    email = userinfo1['email'];
    XP = 100;
    streak = 15;
    imageUrl = link.toString();

    usersfriends.add(
      CustomUser2(
          name: name, email: email, XP: XP, streak: streak, imageUrl: imageUrl),
    );

    usersfriends.sort();
    print(usersfriends);
    print(usersfriends.length);
    print('lanjodka');
    setState(() {});
  }

  @override
  void initState() {
    getCurrentWeekXP();
    loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Leaderboard',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              height: 330,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 64, 220, 69),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    radius: 55,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileStat(text: XP.toString(), label: "XP"),
                      ProfileStat(
                          text: (usersfriends.indexWhere(
                                      (element) => element.name == name) +
                                  1)
                              .toString(),
                          label: "Rank"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.all(20),
              child: ListView.separated(
                  physics:
                      NeverScrollableScrollPhysics(), // Important for nested scrolling
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(usersfriends[index].imageUrl),
                          ),
                          const SizedBox(width: 10),
                          Text(usersfriends[index].name,
                              style: TextStyle(fontSize: 17))
                        ],
                      ),
                      leading: Text(
                        "${index + 1}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: Text(usersfriends[index].XP.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                        color: Colors.black,
                        indent: 10,
                        endIndent: 10,
                      ),
                  itemCount: usersfriends.length),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String text;
  final String label;

  const ProfileStat({
    Key? key,
    required this.text,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 42, fontWeight: FontWeight.w300, color: Colors.white),
        ),
        Text(label,
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}
