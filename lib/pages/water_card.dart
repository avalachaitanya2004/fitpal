// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

// class WaterPage extends StatefulWidget {
//   const WaterPage({super.key});

//   @override
//   State<WaterPage> createState() => _WaterPageState();
// }

// class _WaterPageState extends State<WaterPage> {
//   int target = 12;
//   int completed = 4;
//   int size = 300;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Hero(
//               tag: "Water",
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Material(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       // color: Colors.grey,
//                       // gradient: LinearGradient(
//                       //   begin: Alignment(0, -1),
//                       //   end: Alignment(0, 1),
//                       //   colors: [
//                       //     Colors.white.withOpacity(0.6),
//                       //     Color(0xFFF3E5F5)
//                       //   ], // Gradient colors
//                       // ),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     height: 170,
//                     // width: double.infinity,
//                     // width: 250,
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   completed = completed - 1;
//                                 });
//                               },
//                               child: Icon(Icons.remove)),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             // color: Colors.grey,
//                             height: 170,
//                             width: 170,
//                             child: LiquidCircularProgressIndicator(
//                               center: SizedBox(
//                                 height: 90,
//                                 width: 90,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: Container(
//                                     color: Colors.grey[100],
//                                     child: Center(
//                                         child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           '${completed}/${target}',
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                         Icon(Icons.track_changes),
//                                       ],
//                                     )),
//                                   ),
//                                 ),
//                               ),
//                               value: completed / target,
//                               valueColor:
//                                   AlwaysStoppedAnimation(Colors.blueAccent),
//                               backgroundColor: Colors.white,
//                               direction: Axis.vertical,
//                               // center: Icon(CupertinoIcons),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   completed = completed + 1;
//                                 });
//                               },
//                               child: Icon(Icons.add)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               children: [
//                 Text(
//                   "Serving Size",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Spacer(),
//                 Row(
//                   children: [
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             size -= 10;
//                           });
//                         },
//                         child: Icon(Icons.remove)),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       "${size}ml",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             size += 10;
//                           });
//                         },
//                         child: Icon(Icons.add)),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               children: [
//                 Text(
//                   "Target Glasses",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Spacer(),
//                 Row(
//                   children: [
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             target -= 1;
//                           });
//                         },
//                         child: Icon(Icons.remove)),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       "${target}",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             target += 1;
//                           });
//                         },
//                         child: Icon(Icons.add)),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/main.dart';
import 'package:fit_pal/pages/HomePages/home.dart';
import 'package:fit_pal/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  int target = 5;
  int completed = 0;
  int size = 0;
  late String uid;

  @override
  void initState() {
    super.initState();
    retrieveUID();
    fetchUserData();
  }

  void retrieveUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uid = user?.uid ?? '';
  }

  Future<void> fetchUserData() async {
    try {
      CollectionReference<Map<String, dynamic>> waterCollection =
          FirebaseFirestore.instance.collection('water');
      CollectionReference<Map<String, dynamic>> streakcollection =
          FirebaseFirestore.instance.collection('StreakandWater');
      String? uid;
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;
      uid = user?.uid;

      // Reference the document for the specified user
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await waterCollection.doc(uid).get();
      DateTime currentDate = DateTime.now();

      // Construct the document ID using the date in yyyy-MM-dd format
      String documentId = currentDate.toIso8601String().substring(0, 10);
      DocumentSnapshot<Map<String, dynamic>> userwater = await streakcollection
          .doc(uid)
          .collection('dates')
          .doc(documentId)
          .get();

      // Check if the document exists
      if (userDocument.exists) {
        Map<String, dynamic> userData = userDocument.data()!;

        // Check if the 'target' field exists and is not null
        if (userData.containsKey('target') && userData['target'] != null) {
          setState(() {
            target = userData['target'];
          });
        }

        // Check if the 'completed' field exists and is not null
        if (userwater.exists && userwater['waterintake'] != null) {
          setState(() {
            completed = userwater['waterintake'];
          });
        }

        // Check if the 'size' field exists and is not null
        if (userData.containsKey('quantity') && userData['quantity'] != null) {
          setState(() {
            print('randioo');
            size = userData['quantity'] as int;
            print('randioiiiii');
          });
        }
      } else {
        // Document does not exist for the specified user
        print('Document does not exist for user with UID: $uid');
      }
    } catch (e) {
      // Handle any errors
      print('Failed to fetch user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(size);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Hero(
              tag: "Water",
              child: GestureDetector(
                onTap: () {},
                child: Material(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 170,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                completed = completed - 1;
                                Dataservices dataservices =
                                    Dataservices(uid: uid);
                                dataservices.updateComplete(completed);
                              });
                            },
                            child: Icon(Icons.remove),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 170,
                            width: 170,
                            child: LiquidCircularProgressIndicator(
                              center: SizedBox(
                                height: 90,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.grey[100],
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${completed}/${target}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Icon(Icons.track_changes),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              value: completed / target,
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.blueAccent),
                              backgroundColor: Colors.white,
                              direction: Axis.vertical,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                completed = completed + 1;
                                Dataservices dataservices =
                                    Dataservices(uid: uid);
                                dataservices.updateComplete(completed);
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  "Serving Size",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          size -= 10;
                        });
                      },
                      child: Icon(Icons.remove),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${size}ml",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          size += 10;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  "Target Glasses",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          target -= 1;
                        });
                      },
                      child: Icon(Icons.remove),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${target}",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          target += 1;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Spacer(),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: GestureDetector(
                      onTap: () {
                        Dataservices dataservices = Dataservices(uid: uid);
                        dataservices.updateQuantity(size);
                        dataservices.updateTarget(target);
                        //run to home page
                      },
                      child: Container(
                          color: Colors.blue,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
