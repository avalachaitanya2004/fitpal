import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataBaseServices/calorie.dart';
import 'package:fit_pal/DataFood/food.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/food.dart';
import 'package:fit_pal/models/food_card.dart';
import 'package:fit_pal/models/workout_home_card.dart';
import 'package:fit_pal/pages/preview_food.dart';
import 'package:fit_pal/pages/water_card.dart';
import 'package:fit_pal/utility/GlassMorphism.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:fit_pal/utility/date_picker_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health/health.dart';
// import 'package:health/health.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fit_pal/DataWorkout/assignworkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:health/health.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String uid;
  late List<Excersise> excercises = [];
  List<Food> todays = [
    // Food('BreakFast', 1000, 10, 22, 33, 100, 'Apple', ''),
    // Food('Lunch', 3090, 33, 22, 53, 1000, 'Apple', ''),
    // Food('Dinner', 8003, 99, 82, 33, 99, 'Apple', ''),
    // Food('Supper', 1500, 18, 92, 33, 700, 'Apple', '')
  ];

  int target = 0;
  int completed = 0;
  int _getsteps = 0;
  int bpm = 0;

  Future fetchStepData() async {
    Health().configure(useHealthConnectIfAvailable: true);
    int? steps;
    var types = [
      HealthDataType.STEPS,
    ];
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    var permissions = [
      HealthDataAccess.READ,
    ];
    bool request =
        await Health().requestAuthorization(types, permissions: permissions);
    if (request) {
      try {
        steps = await Health().getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print(error);
      }
      print("total steps $steps");
      setState(() {
        _getsteps = (steps == null) ? 0 : steps;
      });
    } else {
      print("not authorized");
    }
  }

  Future fetchBPMData() async {
    Health().configure(useHealthConnectIfAvailable: true);
    int? steps;
    var types = [
      HealthDataType.HEART_RATE,
    ];
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    var permissions = [
      HealthDataAccess.READ,
    ];
    bool request =
        await Health().requestAuthorization(types, permissions: permissions);
    if (request) {
      try {
        steps = await Health().getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print(error);
      }
      print("total steps $steps");
      setState(() {
        bpm = (steps == null) ? 0 : steps;
      });
    } else {
      print("not authorized");
    }
  }

  int weekXP = 0;
  int todayXP = 0;

  Future<int> getCurrentWeekXP(String userId) async {
    // Get the start and end dates for the current week
    final firestoreInstance = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month,
        now.day - now.weekday + 1); // Start date of the current week (Monday)
    DateTime endDate = startDate
        .add(Duration(days: 6)); // End date of the current week (Sunday)

    // Query Firestore for XP within the current week's range
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestoreInstance.collection('XP').doc(userId).get();

    // Initialize a map to store XP for each date in the current week
    Map<String, int> currentWeekXP = {};

    // Extract data from the document snapshot
    Map<String, dynamic> data = documentSnapshot.data()!;

    // Iterate over the data
    data.forEach((key, value) {
      DateTime date = DateTime.parse(key);
      // Check if the date is within the current week's range
      if (date.isAfter(startDate.subtract(Duration(days: 1))) &&
          date.isBefore(endDate.add(Duration(days: 1)))) {
        currentWeekXP[key] = value;
      }
    });
    int s = 0;

    DateTime date2 = DateTime.now();
    String dateString = date2.toIso8601String().substring(0, 10);
    currentWeekXP.forEach((date, xp) {
      if (dateString == date) {
        print("yes");
        setState(() {
          todayXP = xp;
        });
      }
      s += xp;
    });
    setState(() {
      weekXP = s;
    });

    return s;
  }

  @override
  void initState() {
    super.initState();
    retrieveUID();
    fetchTodayWorkouts();
    // if (Platform.isIOS) {
    fetchBPMData();
    fetchStepData();

    fetchUserData();
    getCurrentWeekXP(uid);
    callme();
    feedToModel();
    calori();
  }

  Future<void> feedToModel() async {
    String baseUrl, url = '', query = '';
    baseUrl = 'http://10.81.16.240:5000/api2?';
    // if (Platform.isAndroid) {
    //   baseUrl = 'http://10.0.2.2:5000/api2?';
    // } else {
    //   baseUrl = 'http://localhost:5000/api2?';
    // }
    var args2 = [
      'gender',
      'age',
      'height',
      'weight',
      'duration',
      'heart_rate',
      'body_temp'
    ];
    List<dynamic> seg2 = [0, 18, 170.5, 60, 24, 100.5, 38.3];
    for (int i = 0; i < seg2.length; i++) {
      if (i > 0) query += '&';
      query += '${args2[i]}=${Uri.encodeComponent(seg2[i].toString())}';
    }
    setState(() {
      url = baseUrl + query;
    });
    var data = await fetchdata(url);
    var decoded = jsonDecode(data);
    int caloriesBurnt = decoded['calories_burned'];
    CalorieService calorieService =
        CalorieService(uid: FirebaseAuth.instance.currentUser!.uid);
    calorieService.addCaloriesForCurrentDate(caloriesBurnt);
    print(caloriesBurnt);
  }

  void retrieveUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uid = user?.uid ?? '';
  }

  void fetchTodayWorkouts() async {
    InitializeWorkout initializeWorkout = InitializeWorkout(uid: uid);
    List<Workout> todayWorkouts =
        await initializeWorkout.getWorkoutsForCurrentDay();

    List<Excersise> convertedWorkouts = todayWorkouts.map((workout) {
      // Convert each Workout object to Exercise object
      return Excersise(name: workout.name, reps: workout.reps);
    }).toList();

    setState(() {
      excercises = convertedWorkouts;
    });
  }

  bool streak = false;
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
        // Access the data for the user
        Map<String, dynamic> userData = userDocument.data()!;

        // Now you can access specific fields from the userData map

        // Replace 'field1' with your field name
        setState(() {
          target = userData['target'];
          completed = userwater['waterintake'];
        });
        // Replace 'field2' with your field name

        // Do something with the retrieved data
      } else {
        // Document does not exist for the specified user
        print('Document does not exist for user with UID: $uid');
      }
    } catch (e) {
      // Handle any errors
      print('Failed to fetch user data: $e');
    }
  }

  void callme() async {
    List<FoodLite> hii = [];
    InitializeFoods initializeFoods =
        InitializeFoods(uid: FirebaseAuth.instance.currentUser!.uid);
    hii = await initializeFoods.getFoodForCurrentDay();
    for (var a in hii) {
      todays.add(Food(a.timeOfDay, 90, 90, 90, 40, a.weight, a.name, ''));
    }
    print(hii.length);
    print(todays.length);
    print('++');
  }

  int calorie = 0;

  void calories(String FormattedDate) async {
    CalorieService calorieService =
        CalorieService(uid: FirebaseAuth.instance.currentUser!.uid);
    Map<String, int>? caloriesMap =
        await calorieService.getCaloriesForDate(FormattedDate);

    if (caloriesMap != null) {
      calorie = caloriesMap['caloriesToBurn']!;
    } else {
      calorie = 0;
    }
  }

  void calori() async {
    DateTime date = DateTime.now();
    String FormattedDate = DateFormat('yyyyMMdd').format(date);
    CalorieService calorieService =
        CalorieService(uid: FirebaseAuth.instance.currentUser!.uid);
    Map<String, int>? caloriesMap =
        await calorieService.getCaloriesForDate(FormattedDate);

    if (caloriesMap != null) {
      calorie = caloriesMap['caloriesToBurn']!;
    } else {
      calorie = 0;
    }
  }

  final PageController _pages1 = PageController();
  final TextStyle _slider = TextStyle(
      fontFamily: 'Roboto', fontSize: 15, fontWeight: FontWeight.w500);
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: Duration(seconds: 1),
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: RadialGradient(
        radius: 1.2,
        // center: Alignment(0, _pos.value),
        center: Alignment(0, -1),
        // radius:0.5,
        colors: [Color.fromARGB(255, 123, 69, 232), Colors.white],
        stops: [0.0, 1.0],
      )),
      // color: Colors.blue,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  String formattedDate = DateFormat('yyyyMMdd').format(date);
                  calories(formattedDate);
                  print(formattedDate);
                  setState(() {
                    // _selectedValue = date;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // page view for calorie intake and exit with an indicator
            Container(
              // color: Colors.blue,
              // color: Colors.blue,
              height: 250,
              child: PageView(
                controller: _pages1,
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            calorie.toString(),
                            style: TextStyle(
                              height: 0.8,
                              // fontFamily: 'Bebas_Neue',
                              letterSpacing: -10,
                              fontSize: 130,
                              color: Colors.white.withOpacity(0.9),
                              // backgroundColor: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Kcal left',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GlassMorphism(
                                    blur: 50,
                                    // margin: EdgeInsets.all(10),
                                    // color: Colors.blue,
                                    // height: 80,
                                    // width: 90,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/steps.svg',
                                            width: 18,
                                            height: 18,
                                            color: Colors.brown,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_getsteps}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  // color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                'Steps',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: GlassMorphism(
                                  blur: 50,
                                  // margin: EdgeInsets.all(10),
                                  // color: Colors.red,
                                  // height: 80,
                                  // width: 90,
                                  child: streak
                                      ? Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.flame,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '176',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .blue, // Ensure color is set as needed
                                                    ),
                                                  ),
                                                  SizedBox(height: 1),
                                                  Text(
                                                    'Streak',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Stack(
                                            alignment: Alignment
                                                .topCenter, // Aligns children to the top center of the stack
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  CupertinoIcons.flame,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                              Positioned(
                                                bottom:
                                                    10, // Adjusts the bottom position to align as a subscript
                                                right:
                                                    5, // Adjusts the right position to make it visually a subscript
                                                child: Icon(
                                                  Icons.warning_amber_rounded,
                                                  color: Colors.red,
                                                  size:
                                                      16, // Smaller size for subscript styling
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              Expanded(
                                child: GlassMorphism(
                                    blur: 50,
                                    // margin: EdgeInsets.all(10),
                                    // color: Colors.green,
                                    // height: 80,
                                    // width: 90,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.drop,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${completed}/${target}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  // color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                'Water',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '1444',
                            style: TextStyle(
                              // fontFamily: 'Bebas_Neue',
                              height: 0.8,
                              letterSpacing: -10,
                              fontSize: 130,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Kcal to burn',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GlassMorphism(
                                    blur: 50,
                                    // margin: EdgeInsets.all(10),
                                    // color: Colors.blue,
                                    // height: 80,
                                    // width: 90,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '120',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  // color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                'bpm',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: GlassMorphism(
                                  blur: 50,
                                  // margin: EdgeInsets.all(10),
                                  // color: Colors.red,
                                  // height: 80,
                                  // width: 90,
                                  child: streak
                                      ? Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.bolt,
                                                color: Colors.yellow[900],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${todayXP}',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      // color: Colors.blue,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 1,
                                                  ),
                                                  Text(
                                                    'Today',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Stack(
                                            alignment: Alignment
                                                .topCenter, // Aligns children to the top center of the stack
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Icon(
                                                  CupertinoIcons.flame,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                              Positioned(
                                                bottom:
                                                    10, // Adjusts the bottom position to align as a subscript
                                                right:
                                                    5, // Adjusts the right position to make it visually a subscript
                                                child: Icon(
                                                  Icons.warning_amber_rounded,
                                                  color: Colors.red,
                                                  size:
                                                      16, // Smaller size for subscript styling
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              Expanded(
                                child: GlassMorphism(
                                    blur: 50,
                                    // margin: EdgeInsets.all(10),
                                    // color: Colors.green,
                                    // height: 80,
                                    // width: 90,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.bolt_fill,
                                            color: Colors.yellow[900],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${weekXP}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  // color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                'Week',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            SmoothPageIndicator(
                controller: _pages1,
                count: 2,
                effect: const ScrollingDotsEffect(
                  // border: Border.all(color: Colors.grey,width: 1),
                  dotColor: Colors.white,
                  activeDotColor: Color.fromARGB(255, 169, 131, 239),
                  activeStrokeWidth: 2.6,
                  activeDotScale: 1.0,
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 9,
                  dotWidth: 9,
                )),
            Container(
              padding: EdgeInsets.only(left: 30, top: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.left,
                "Daily Meals",
                style: TextStyle(
                  fontFamily: "roboto",
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.blue,
              // width: 500,
              child: CustomSlidingSegmentedControl<int>(
                // fixedWidth: 130,
                // height: 50,

                isStretch: true,
                initialValue: _page,
                children: {
                  0: Text(
                    'Meals',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: _page == 0 ? Colors.black : Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  ),
                  1: Text(
                    'Workouts',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: _page == 1 ? Colors.black : Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  ),
                  2: Text(
                    'Water',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: _page == 2 ? Colors.black : Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  ),
                },
                decoration: BoxDecoration(
                  // color: CupertinoColors.lightBackgroundGray,
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
                onValueChanged: (v) {
                  setState(() {
                    _page = v;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_page == 0)
              Column(
                children: [
                  ...List.generate(todays.length, (index) {
                    return FoodCard(food: todays[index]);
                  }),
                  SizedBox(height: 76),
                ],
              ),
            if (_page == 1)
              Column(
                children: [
                  WorkoutHomeCard(excercise: excercises),
                  SizedBox(
                    height: 76,
                  ),
                ],
              ),
            if (_page == 2)
              Column(
                children: [
                  Hero(
                    tag: 'Water',
                    child: Material(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
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
                              height: 170,
                              // width: double.infinity,
                              // width: 250,
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
                                            dataservices
                                                .updateWaterIntakebySubOne();
                                          });
                                        },
                                        child: Icon(Icons.remove)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      // color: Colors.grey,
                                      height: 170,
                                      width: 170,
                                      child: LiquidCircularProgressIndicator(
                                        center: SizedBox(
                                          height: 90,
                                          width: 90,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              color: Colors.grey[100],
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${completed}/${target}',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Icon(Icons.track_changes),
                                                ],
                                              )),
                                            ),
                                          ),
                                        ),
                                        value: completed / target,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.blueAccent),
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
                                            Dataservices dataservices =
                                                Dataservices(uid: uid);
                                            dataservices
                                                .updateWaterIntakebyOne();
                                          });
                                        },
                                        child: Icon(Icons.add)),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: -15,
                              top: -15,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20.0, top: 20),
                                child: IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () {
                                    print("pushed");
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return WaterPage();
                                    }));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 66,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
