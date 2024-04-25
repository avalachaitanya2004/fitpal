import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/DataFood/food.dart';
import 'package:fit_pal/models/food_data.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:fit_pal/models/food.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PreviewFood extends StatefulWidget {
  const PreviewFood(
      {super.key,
      required this.image,
      required this.imagepath,
      required this.Category,
      required this.Predicted});
  final XFile image;
  final String imagepath;
  final String Category;
  final String Predicted;
  @override
  State<PreviewFood> createState() => _PreviewFoodState();
}

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  print("object");
  return response.body;
}

class _PreviewFoodState extends State<PreviewFood>
    with TickerProviderStateMixin {
  late AnimationController _con;
  late Animation<double> ani;
  bool isloading = true;

  String url = '';
  double weight = 100;

  var decoded;

  Future<void> getData() async {
    //enter data

    isloading = false;
  }

  @override
  void initState() {
    url = widget.imagepath;
    print("url ${url}");
    isloading = true;
    getData();
    super.initState();
    _con =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    ani = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _con, curve: Curves.easeOut));
    _con.forward();
    image = widget.image;
    imagepath = widget.imagepath;
    print(imagepath);
    protein = getProtein(widget.Predicted);
    carbs = getCarbs(widget.Predicted);
    fat = getfat(widget.Predicted);
    proteinper = protein / (protein + carbs + fat);
    carbsper = carbs / (protein + carbs + fat);
    fatper = fat / (protein + carbs + fat);
    // cal = getCalories(widget.Predicted).toDouble();
    print('$proteinper,$carbsper ,$fatper ,$cal');

    // feedToModel();
  }

  late Food food;

  // Future<void> feedToModel() async {
  //   List<String> segments = [];
  //   int segmentLength = 90;
  //   print("object");
  //   for (int i = 0; i < imagepath.length; i += segmentLength) {
  //     int end = (i + segmentLength < imagepath.length)
  //         ? i + segmentLength
  //         : imagepath.length;
  //     segments.add(imagepath.substring(i, end));
  //   }
  //   print("object");
  //   String baseUrl, url = '';
  //   baseUrl = 'http://10.81.16.240:5000/api?'; //physical device
  //   // if (Platform.isAndroid) {
  //   //   baseUrl = 'http://10.0.2.2:5000/api?';
  //   // } else {
  //   //   baseUrl = 'http://localhost:5000/api?';
  //   // }
  //   String query = '';
  //   for (int i = 0; i < segments.length; i++) {
  //     if (i > 0) {
  //       query += '&';
  //     }
  //     query += 'v${i + 1}=' + Uri.encodeComponent(segments[i]);
  //   }
  //   setState(() {
  //     url = baseUrl + query;
  //   });
  //   print(url);
  //   var data = await fetchdata(url);
  //   print("hii");
  //   decoded = jsonDecode(data);
  //   Predicted = decoded['Predicted'];
  //   Category = decoded['Category'];
  //   print(Predicted);
  //   print(Category);
  //   print(url);
  //   url = imagepath;
  //   String name = Predicted;
  //   double size = weight;
  //   // String title = a.timeOfDay;
  //   double calorie = getCalories(name).toDouble() * size;
  //   double protein = getProtein(name).toDouble() * size;
  //   double carb = getCarbs(name).toDouble() * size;
  //   double fat = getfat(name).toDouble() * size;
  //   // double tot = carb + fat + protein;
  //   // carb = (carb * 100) / tot;
  //   // fat = (fat * 100) / tot;
  //   // protein = (protein * 100) / tot;
  //   food = (Food("title", calorie, protein, carb, fat, size, name, ''));
  // }

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }

// class _PreviewFoodState extends State<PreviewFood> with TickerProviderStateMixin {
//   late AnimationController _con;
//   late Animation<double> ani;
//   late XFile image;
//   String decodedData = '';

//   @override
//   void initState() {
//     super.initState();
//     _con = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     ani = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _con, curve: Curves.easeOut));
//     _con.forward();

//     image = widget.image;
//     feedToModel();
//   }

  // Future<void> feedToModel() async {
  //   // Assuming you need to send the file content to a server:
  //   String baseUrl = Platform.isAndroid ? 'http://10.0.2.2:5000/api' : 'http://localhost:5000/api';
  //   var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
  //     ..files.add(await http.MultipartFile.fromPath('file', image.path));

  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     String responseData = await response.stream.bytesToString();
  //     var decoded = jsonDecode(responseData);
  //     setState(() {
  //       decodedData = decoded.toString(); // Assuming you want to display this data
  //     });
  //     print(decodedData);
  //   }
  // }

  // @override
  // void didUpdateWidget(PreviewFood oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _con.forward(from: 1); // Start the animation from the beginning
  // }

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

  late double proteinper;
  late double fatper;
  late double carbsper;
  late int protein;
  late int fat;
  late int carbs;
  double cal = 0;

  late XFile image;
  late String imagepath;
  @override
  Widget build(BuildContext context) {
    // cal = cal * weight;
    cal = getCalories(widget.Predicted).toDouble() * weight;
    return Scaffold(
      backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   // title: Text('Nutrition'),
      //   backgroundColor: Colors.transparent,
      // ),
      body: true
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
                                      InitializeFoods initializeFoods =
                                          InitializeFoods(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid);
                                      initializeFoods.addFood(
                                          widget.Predicted, weight, url, '');
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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
                                        'Breakfast',
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
                                      "${widget.Predicted}",
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
                                    '${weight}g',
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
                                  Text('${cal}kcal',
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
                                                  weight -= 10;
                                                });
                                              },
                                              child: Icon(Icons.remove)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${weight}g',
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
                                                  weight += 10;
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
                                                  returnfraction(proteinper);
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
                                                Container(
                                                  width: double.infinity,
                                                  height: innerContainerHeight,

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
                                                            '${protein * weight}'),
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
                                                  returnfraction(carbsper);
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
                                                Container(
                                                  width: double.infinity,
                                                  height: innerContainerHeight,
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
                                                            '${carbs * weight}'),
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
                                                  returnfraction(fatper);
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
                                                Container(
                                                  width: double.infinity,
                                                  height: innerContainerHeight,
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
                                                            '${fat * weight}'),
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
