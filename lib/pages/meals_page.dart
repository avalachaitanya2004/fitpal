import 'package:fit_pal/Controllers/custom_rect_tween.dart';
import 'package:fit_pal/Controllers/hero_dialog_route.dart';
import 'package:fit_pal/models/food.dart';
import 'package:fit_pal/models/food_dis.dart';
import 'package:fit_pal/models/food_popup.dart';
import 'package:fit_pal/pages/add_food_page.dart';
import 'package:flutter/material.dart';

class MealsPage extends StatelessWidget {
  MealsPage({super.key});
  final List<Food> today = [
    Food('BreakFast', 1000, 10, 22, 33, 100, 'Apple'),
    Food('Lunch', 3090, 33, 22, 53, 1000, 'Apple'),
    Food('Dinner', 8003, 99, 82, 33, 99, 'Apple'),
    Food('Supper', 1500, 18, 92, 33, 700, 'Apple')
  ];

  @override
  Widget build(BuildContext context) {
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
