import 'package:bounce_tap/bounce_tap.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/pages/edit_profile.dart';
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
  late Dataservices dataservices;
  String name = '';
  String email = '';
  double weight = 0.0;
  int height = 0;

  @override
  void initState() {
    super.initState();
    String? uid = AuthService.getUID();
    if (uid != null) {
      dataservices = Dataservices(uid: uid);
      dataservices.getUserInfo().then((userInfo) {
        setState(() {
          name = userInfo['name'] ?? '';
          email = userInfo['email'] ?? '';
          weight = userInfo['weight'] ?? '';
          height = userInfo['height'] ?? '';
        });
      });
    }
  }

  Widget buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg"),
          radius: 60,
        ),
        const SizedBox(height: 20),
        Text(name, //NAME
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
        buildStatsCard('Total XP', '9090', Icons.bolt, Colors.amber),
        buildStatsCard('Streak', '177', CupertinoIcons.flame, Colors.red),
        buildStatsCard(
            'Weight', weight.toString(), Icons.settings, Colors.blue),
        buildStatsCard('Height', height.toString(), Icons.update, Colors.green),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
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
