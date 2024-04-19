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
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  int target = 12;
  int completed = 4;
  int size = 300;

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {},
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
