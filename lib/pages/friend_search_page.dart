import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/DataFriends/getfriends.dart';
import 'package:bounce_tap/bounce_tap.dart';

class FriendSearch extends StatefulWidget {
  const FriendSearch({Key? key});

  @override
  State<FriendSearch> createState() => _FriendSearchState();
}

class _FriendSearchState extends State<FriendSearch> {
  List<String> names = [];
  List<String> foundFriends = [];
  int selectedTab = 0; // 0 for "Friends", 1 for "Add Friends"

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    UserData userData = UserData(uid: AuthService.getUID()!, statusMap: {});
    names = await userData.getUserIdsWithStatusU();
    foundFriends = await userData.getUserIdsWithStatusF();
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
