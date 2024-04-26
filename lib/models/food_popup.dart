import 'dart:ui';

import 'package:fit_pal/Controllers/custom_rect_tween.dart';
import 'package:fit_pal/models/food.dart';
import 'package:flutter/material.dart';

class FoodPopup extends StatelessWidget {
  const FoodPopup({super.key, required this.food});
  final Food food;
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

  @override
  Widget build(BuildContext context) {
    print(food.calorie);
    return Hero(
      // createRectTween: (begin, end) {
      //   return CustomRectTween(begin: begin!, end: end!);
      // },
      tag: food.calorie,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.lightGreen,
        child: Container(
          // color: Colors.blue,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(food.imageurl),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              // FloatingActionButton(
                              //   shape: CircleBorder(),
                              //   elevation: 30,
                              //   backgroundColor: Colors.white,
                              //   onPressed: () {},
                              //   child: Icon(Icons.add),
                              // ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  food.name,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    // GestureDetector(
                                    //     onTap: () {
                                    //       // setState(() {
                                    //       //   food.size -= 10;
                                    //       // });
                                    //     },
                                    // child: Icon(Icons.remove)),
                                    // SizedBox(
                                    //   width: 8,
                                    // ),
                                    // Text(
                                    //   '${food.size}g',
                                    //   style: TextStyle(
                                    //     fontSize: 20,
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: 8,
                                    // ),
                                    // GestureDetector(
                                    //     // onTap: () {
                                    //     //   setState(() {
                                    //     //     food.size += 10;
                                    //     //   });
                                    //     // },
                                    //     child: Icon(Icons.add)),
                                  ],
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
                                          color:
                                              Color.fromARGB(255, 170, 161, 226)
                                                  .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        height: double.infinity,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Text('Protein'),
                                            ),
                                            Spacer(),
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: double.infinity,
                                              height: innerContainerHeight,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                        255, 170, 161, 226)
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child:
                                                        Text('${food.protein}'),
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
                                          color:
                                              Color.fromARGB(255, 170, 161, 226)
                                                  .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        height: double.infinity,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Text('Carbs'),
                                            ),
                                            Spacer(),
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: double.infinity,
                                              height: innerContainerHeight,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                        255, 170, 161, 226)
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child:
                                                        Text('${food.carbs}'),
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
                                          color:
                                              Color.fromARGB(255, 170, 161, 226)
                                                  .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        height: double.infinity,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Text('Fat'),
                                            ),
                                            Spacer(),
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              width: double.infinity,
                                              height: innerContainerHeight,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                        255, 170, 161, 226)
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text('${food.fat}'),
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
        ),
      ),
    );
  }
}
