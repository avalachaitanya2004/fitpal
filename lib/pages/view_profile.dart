import 'package:bounce_tap/bounce_tap.dart';
import 'package:fit_pal/pages/friend_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ViewProfile extends StatefulWidget {
  final CustomUser user;
  const ViewProfile({super.key, required this.user});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  Widget buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg"),
          radius: 60,
        ),
        const SizedBox(height: 20),
        Text(widget.user.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(widget.user.email,
            style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
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
        buildStatsCard(
            'Total XP', widget.user.XP.toString(), Icons.bolt, Colors.amber),
        buildStatsCard('Streak', widget.user.streak.toString(),
            CupertinoIcons.flame, Colors.red),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            buildStatsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
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
