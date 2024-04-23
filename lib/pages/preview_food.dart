import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:fit_pal/models/food.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PreviewFood extends StatefulWidget {
  const PreviewFood({super.key, required this.image, required this.imagepath});
  final XFile image;
  final String imagepath;
  @override
  State<PreviewFood> createState() => _PreviewFoodState();
}

class _PreviewFoodState extends State<PreviewFood>
    with TickerProviderStateMixin {
  late AnimationController _con;
  late Animation<double> ani;
  bool isloading = true;
  @override
  Future<void> getData() async {
    //enter data

    isloading = false;
  }

  void initState() {
    // TODO: implement initState
    isloading = true;
    getData();

    super.initState();
    _con =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    ani = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _con, curve: Curves.easeOut));
    _con.forward();
    image = widget.image;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _con.dispose();
    super.dispose();
  }
  // @override
  // void didUpdateWidget(PreviewFood oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _con.forward(from: 1); // Start the animation from the beginning
  // }

  Food food = Food('breakfast', 40.0, 30.0, 20.0, 40.0, 100.0, 'Apple', '');
  double returnfraction(double per) {
    if (per >= 12 && per <= 80) {
      return per / 100;
    } else {
      if (per <= 12) {
        return 12 / 100;
      } else {
        return 80 / 100;
      }
    }
  }

  late XFile image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   // title: Text('Nutrition'),
      //   backgroundColor: Colors.transparent,
      // ),
      body: isloading
          ? Container(
              // color: Colors.blue,
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(image.path)),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: [
                    // name and quantity and type
                    SafeArea(
                      child: Container(
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Material(
                                    elevation: 10,
                                    shape: CircleBorder(),
                                    color: Colors.white.withOpacity(0.4),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                          // elevation:10
                                          backgroundColor:
                                              Colors.white.withOpacity(0.4),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 5,
                                  ),
                                  Text(
                                    'Nutrition',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                  FloatingActionButton(
                                    shape: CircleBorder(),
                                    elevation: 30,
                                    backgroundColor: Colors.white,
                                    onPressed: () {
                                      // do smthing here
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, left: 20),
                                child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // alignment: Alignment.topLeft,

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${food.title}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Apples',
                                      // overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Text(
                                    '${food.size}g',
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      // backgroundColor: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Nutrition Value',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Spacer(),
                                  Text('${food.calorie}kcal',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.7),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Flexible(
                      flex: 4,
                      child: Container(
                          // color: Colors.green,
                          ),
                    ),
                    // proteins carbs and fats and serving size
                    Flexible(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        // height: 300,
                        width: double.infinity,
                        child: Column(
                          children: [
                            // serving size adjustments
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Serving Size',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    // color: Colors.pink[100],
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 170, 161, 226)
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  food.size -= 10;
                                                });
                                              },
                                              child: Icon(Icons.remove)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${food.size}g',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  food.size += 10;
                                                });
                                              },
                                              child: Icon(Icons.add)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //proteins carbs and fats
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 10, bottom: 40),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          double innerContainerHeight =
                                              constraints.maxHeight *
                                                  returnfraction(food.protein);
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                      255, 170, 161, 226)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            margin: EdgeInsets.all(5),
                                            height: double.infinity,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text('Protein'),
                                                ),
                                                Spacer(),
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: double.infinity,
                                                  height: innerContainerHeight *
                                                      ani.value,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                            255, 170, 161, 226)
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Text(
                                                            '${food.protein}%'),
                                                      )),
                                                  // color: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          double innerContainerHeight =
                                              constraints.maxHeight *
                                                  returnfraction(food.carbs);
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                      255, 170, 161, 226)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            margin: EdgeInsets.all(5),
                                            height: double.infinity,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text('Carbs'),
                                                ),
                                                Spacer(),
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: double.infinity,
                                                  height: innerContainerHeight *
                                                      ani.value,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                            255, 170, 161, 226)
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Text(
                                                            '${food.carbs}%'),
                                                      )),
                                                  // color: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          double innerContainerHeight =
                                              constraints.maxHeight *
                                                  returnfraction(food.fat);
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                      255, 170, 161, 226)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            margin: EdgeInsets.all(5),
                                            height: double.infinity,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text('Fat'),
                                                ),
                                                Spacer(),
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: double.infinity,
                                                  height: innerContainerHeight *
                                                      ani.value,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                            255, 170, 161, 226)
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Text(
                                                            '${food.fat}%'),
                                                      )),
                                                  // color: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // color: Colors.blue,
            )
          : Container(
              child: Text('loading'),
            ),
    );
  }
}
