import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
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
              height: 315,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 64, 220, 69),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg"),
                    radius: 55,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Nandu",
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
                    children: const [
                      ProfileStat(text: "45", label: "XP"),
                      ProfileStat(text: "35", label: "Rank"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            ExpandedListView(),
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

class ExpandedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView.separated(
          physics:
              NeverScrollableScrollPhysics(), // Important for nested scrolling
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg"),
                  ),
                  const SizedBox(width: 10),
                  Text("Nandu ", style: TextStyle(fontSize: 17))
                ],
              ),
              leading: Text(
                "${index + 1}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: const Text("1300XP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.black,
                indent: 10,
                endIndent: 10,
              ),
          itemCount: 16),
    );
  }
}
