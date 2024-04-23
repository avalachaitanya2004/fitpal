import 'package:fit_pal/Controllers/hero_dialog_route.dart';
import 'package:fit_pal/DataFood/food.dart';
import 'package:fit_pal/models/food.dart';
import 'package:fit_pal/models/food_data.dart';
import 'package:fit_pal/models/food_dis.dart';
import 'package:fit_pal/models/food_popup.dart';
import 'package:fit_pal/pages/add_food_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MealsPage extends StatefulWidget {
  MealsPage({Key? key}) : super(key: key);

  @override
  _MealsPageState createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late String uid = '';
  late Future<List<FoodLite>> foodForToday;

  @override
  void initState() {
    super.initState();
    retrieveUID();
    InitializeFoods initializeFoods = InitializeFoods(uid: uid);
    foodForToday = initializeFoods.getFoodForCurrentDay();
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

  final List<Food> today = [];

  @override
  Widget build(BuildContext context) {
    today.clear();
    foodForToday.then((foodList) {
      for (var foodLite in foodList) {
        today.add(
          Food(foodLite.timeOfDay, 56, 56, 67, 67, foodLite.weight,
              foodLite.name, foodLite.url),
        );
      }
      setState(() {});
    });

    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.blue,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Hero(
                      tag: "Add-Food",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddFood();
                            }));
                          },
                          child: Container(
                            color: Colors.blue,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
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
                      '5th April, \nThursday',
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
