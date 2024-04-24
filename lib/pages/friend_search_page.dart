import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/DataFriends/getfriends.dart';
import 'package:bounce_tap/bounce_tap.dart';

class CustomUser {
  final String name;
  final String email;
  final int XP;
  final int streak;

  CustomUser(
      {required this.name,
      required this.email,
      required this.XP,
      required this.streak});
}

class FriendSearch extends StatefulWidget {
  const FriendSearch({Key? key});

  @override
  State<FriendSearch> createState() => _FriendSearchState();
}

class _FriendSearchState extends State<FriendSearch> {
  List<String> names = [];
  List<String> foundFriends = [];
  List<CustomUser> usersfriends = [];
  List<CustomUser> notusersfriends = [];
  int selectedTab = 0; // 0 for "Friends", 1 for "Add Friends"

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<int> getTotalXP(String userId) async {
    // Get the start and end dates for the current week
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
    int sum = 0;
    // Iterate over the data
    data.forEach((key, value) {
      // Check if the date is within the current week's range
      sum += value as int;
      currentWeekXP[key] = value;
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
    });

    return sum;
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    UserData userData = UserData(uid: uid, statusMap: {});
    names = await userData.getUserIdsWithStatusU();
    for (int i = 0; i < names.length; i++) {
      String uid1 = names[i];
      Dataservices dataservices = Dataservices(uid: uid1);
      Map<String, dynamic> userinfo1 = await dataservices.getUserInfo();
      int XP1 = await getTotalXP(uid1);
      notusersfriends.add(CustomUser(
          name: userinfo1['name'],
          email: userinfo1['email'],
          XP: XP1,
          streak: 5));
    }
    foundFriends = await userData.getUserIdsWithStatusF();
    for (int i = 0; i < foundFriends.length; i++) {
      String uid1 = foundFriends[i];
      Dataservices dataservices = Dataservices(uid: uid1);
      Map<String, dynamic> userinfo1 = await dataservices.getUserInfo();
      int XP1 = await getTotalXP(uid1);
      usersfriends.add(CustomUser(
          name: userinfo1['name'],
          email: userinfo1['email'],
          XP: XP1,
          streak: 5));
    }
    setState(() {});
  }

  void filter(String value) {
    setState(() {
      foundFriends = names;
    });
  }

  Widget buildTab(int index, String title, IconData icon) {
    bool isSelected = selectedTab == index;
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.yellow : Colors.green,
        ),
        onPressed: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 30, color: isSelected ? Colors.white : Colors.black),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 30),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTab(0, 'Friends', CupertinoIcons.person_alt),
                  buildTab(1, 'Add Friends', CupertinoIcons.person_add_solid),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: filter,
                decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return selectedTab == 0
                        ? ProfileCard(name: foundFriends[index])
                        : ProfileCardAdd(name: names[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.grey[300]),
        title: Text(name),
        trailing: const Text('lv 100'),
      ),
    );
  }
}

class ProfileCardAdd extends StatelessWidget {
  const ProfileCardAdd({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey[300]),
      title: Text(name),
      trailing: IconButton(
        icon: const Icon(Icons.person_add),
        onPressed: () {},
      ),
    );
  }
}
