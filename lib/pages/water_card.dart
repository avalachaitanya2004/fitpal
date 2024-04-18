import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  int target = 12;
  int completed = 4;
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
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey,
                    gradient: LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 1),
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Color(0xFFF3E5F5)
                      ], // Gradient colors
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 120,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    completed = completed - 1;
                                  });
                                },
                                child: Icon(Icons.remove)),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              // color: Colors.grey,
                              height: 100,
                              width: 100,
                              child: LiquidCircularProgressIndicator(
                                center: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: Icon(Iconsax.cup4),
                                    ),
                                  ),
                                ),
                                value: completed / target,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.blueAccent),
                                backgroundColor: Colors.white,
                                direction: Axis.vertical,
                                // center: Icon(CupertinoIcons),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    completed = completed + 1;
                                  });
                                },
                                child: Icon(Icons.add)),
                          ],
                        ),
                        Spacer(),
                        Text(
                          '${completed} Glasses Done',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
