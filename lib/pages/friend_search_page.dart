import 'package:bounce_tap/bounce_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FriendSearch extends StatefulWidget {
  const FriendSearch({super.key});

  @override
  State<FriendSearch> createState() => _FriendSearchState();
}

class _FriendSearchState extends State<FriendSearch> {
  List<String> names = ["John Jacobs", "Steve Jobs", "Mark Zuck"];
  List<String> foundFriends = [];
  List<bool> friends = [true, false];
  void filter(String value) {
    setState(() {
      foundFriends = value.isEmpty
          ? names
          : names
              .where((card) => card.toLowerCase().contains(value.toLowerCase()))
              .toList();
    });
  }

  void initState() {
    super.initState();
    foundFriends = names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 34,
                  ),
                ),
                // search bar

                // tab bar
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (friends[0] == false) {
                                friends[0] = true;
                                friends[1] = false;
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: 80,
                            decoration: BoxDecoration(
                              color: friends[0] ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person_alt,
                                  size: 30,
                                  color:
                                      friends[0] ? Colors.white : Colors.black,
                                ),
                                Text(
                                  'Friends',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: friends[0]
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (friends[1] == false) {
                                friends[1] = true;
                                friends[0] = false;
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: 80,
                            decoration: BoxDecoration(
                              color: friends[1] ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person_add_solid,
                                  size: 30,
                                  color:
                                      friends[1] ? Colors.white : Colors.black,
                                ),
                                Text(
                                  'Add Friends',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: friends[1]
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                TextField(
                  onChanged: filter,
                  decoration: InputDecoration(
                    labelText: "Search",
                    suffixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //friends
                if (friends[0])
                  Column(
                    children: List.generate(foundFriends.length, (index) {
                      return ProfileCard(name: names[index]);
                    }),
                  ),
                if (friends[1])
                  Column(
                    children: List.generate(foundFriends.length,
                        (index) => ProfileCardAdd(name: names[index])),
                  )
                // add friends
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Text('lv 100'),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCardAdd extends StatelessWidget {
  const ProfileCardAdd({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              // width: double.infinity,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Text('lv 100'),
                  ],
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 80,
              child: Icon(Icons.person_add_alt_1),
            )),
      ],
    );
  }
}
