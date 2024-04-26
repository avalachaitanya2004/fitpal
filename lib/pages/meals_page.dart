import 'package:fit_pal/Controllers/hero_dialog_route.dart';
import 'package:fit_pal/DataFood/food.dart';
import 'package:fit_pal/models/food.dart';
import 'package:fit_pal/models/food_data.dart';
import 'package:fit_pal/models/food_dis.dart';
import 'package:fit_pal/models/food_popup.dart';
import 'package:fit_pal/pages/add_food_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/models/food_data.dart';

class MealsPage extends StatefulWidget {
  MealsPage({Key? key}) : super(key: key);

  @override
  _MealsPageState createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late String uid = '';

  List<Food> today = [];
  @override
  void initState() {
    super.initState();
    retrieveUID();
    callme();
  }

  void retrieveUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    }
  }

  void callme() async {
    List<FoodLite> hii = [];
    InitializeFoods initializeFoods =
        InitializeFoods(uid: FirebaseAuth.instance.currentUser!.uid);
    hii = await initializeFoods.getFoodForCurrentDay();
    for (var a in hii) {
      String name = a.name;
      double size = a.weight;
      String title = a.timeOfDay;
      double calorie = getCalories(name).toDouble() * size;
      double protein = getProtein(name).toDouble() * size;
      double carb = getCarbs(name).toDouble() * size;
      double fat = getfat(name).toDouble() * size;
      today.add(Food(title, calorie, protein, carb, fat, size, name, a.url));
    }
    setState(() {});
    print(hii.length);
    print(today.length);
    print('lanjaodaka');
    print('++');
  }

  String _getWeekday(DateTime date) {
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    DateTime today1 = DateTime.now();
    String formattedDate = "${today1.day}th ${_getWeekday(today1)}";
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.blue,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () async {
                    var today = DateTime.now();
                    var datePicked = await showDatePicker(
                      context: context,
                      lastDate: DateTime(today.year + 1),
                      firstDate: DateTime(2019),
                      initialDate: DateTime.now(),
                    );
                    print(datePicked);
                  },
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    size: 30,
                  ),
                ),
                Hero(
                  tag: "Add-Food",
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddFood();
                      }));
                    },
                    icon: Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
              automaticallyImplyLeading: false,
              // pinned: true,
              floating: true,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              // title: Text(
              //   '5th April, \nThursday',
              //   style: TextStyle(fontSize: 20),
              // ),
              expandedHeight: 130,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      formattedDate,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: today.length,
                (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return FoodPopup(food: today[index]);
                    }));
                  },
                  child: Hero(
                    tag: today[index].calorie,
                    // createRectTween: (begin, end) {
                    //   return CustomRectTween(begin: begin!, end: end!);
                    // },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FoodDisplay(food: today[index]),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 76,
              ),
            )
          ],
        ),
      ),
    );
  }
}
