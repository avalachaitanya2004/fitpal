import 'package:fit_pal/models/food.dart';
import 'package:fit_pal/models/food_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  bool empty = false;
  bool notpresent = false;
  Food create_obj() {
    String title = "";
    int i;
    for (i = 0; i < 5; i++) {
      if (type[i]) {
        title = types[i];
        break;
      }
    }
    String s = _food.text.toLowerCase().trim();
    s = s.replaceAll(' ', '');
    double size1 = size.toDouble(); // Convert size to double
    String name = _food.text;
    double? calorie = foodData[s]!['caloriespergram']?.toDouble();
    calorie = (calorie! * size1)!;
    double? protein = foodData[s]!['proteinpergram']?.toDouble();
    protein = (protein! * size1)!;
    double? carbs = foodData[s]!['carbohydratespergram']?.toDouble();
    carbs = (carbs! * size1)!;
    double? fat = foodData[s]!['cholesterolpergram']?.toDouble();
    fat = (fat! * size1)!;

    var food = Food(title, calorie, protein, carbs, fat, size1, name);
    return food;

    // later store in backend
  }

  bool check() {
    if (_food.text == "") {
      setState(() {
        empty = true;
      });
      return false;
    }
    setState(() {
      empty = false;
    });
    String s = _food.text.toLowerCase().trim();
    s = s.replaceAll(' ', '');

    if (foodData.containsKey(s)) {
    } else {
      setState(() {
        notpresent = true;
      });
      return false;
    }
    setState(() {
      empty = false;
      notpresent = false;
    });

    return true;
  }

  TextEditingController _food = TextEditingController();
  int size = 100;
  List<String> types = ["Breakfast", "Lunch", "Dinner", "Supper", "Snacks"];
  List<bool> type = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // name of food
            TextField(
              // focusNode: focusNode,
              controller: _food,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fastfood),
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                errorText: empty
                    ? "please fill the name"
                    : (notpresent ? "no in the dataset" : null),
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            //serving size
            Row(
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
                        child: Icon(Icons.remove)),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${size}g",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            size += 10;
                          });
                        },
                        child: Icon(Icons.add)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            //day of the meal
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Type',
                  style: TextStyle(fontSize: 20),
                )),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(types.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (!type[index]) {
                        int i;
                        for (i = 0; i < 5; i++) {
                          setState(() {
                            type[i] = false;
                          });
                        }
                        type[index] = true;
                      }
                    },
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: type[index] ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              types[index],
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    !type[index] ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        )),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Hero(
                      tag: "Add-Food",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: GestureDetector(
                          onTap: () {
                            if (check()) {
                              Food food = create_obj();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                              color: Colors.blue,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
