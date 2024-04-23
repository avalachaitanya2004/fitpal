import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_pal/models/food.dart';

class InitializeFoods {
  final String uid;

  InitializeFoods({required this.uid});

  Future<void> initializeFood() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Food');
      DateTime currentDate = DateTime.now();
      for (int i = 0; i < 60; i++) {
        // Calculate the date for the current iteration
        DateTime date = currentDate.add(Duration(days: i));

        // Construct the document ID using the date in yyyy-MM-dd format
        String documentId = date.toIso8601String().substring(0, 10);

        // Set the document data with integer and boolean variables for each day
        await dataCollection.doc(uid).collection('dates').doc(documentId).set({
          // Create an empty workout subcollection
          'Foods': [],
        });
      }
      print('Data initialized successfully.');
    } catch (e) {
      print('Failed to initialize data: $e');
    }
  }

  Future<void> addFood(String name, double weight, String url) async {
    try {
      DateTime currentDate = DateTime.now();
      String date = currentDate.toIso8601String().substring(0, 10);
      // hh:mm:ss;
      String time =
          "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";

      String timeOfDay = Time(time);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Food');

      // Add a new food entry to the foods subcollection
      await dataCollection
          .doc(uid)
          .collection('dates')
          .doc(date)
          .collection('foods')
          .add({
        'name': name,
        'weight': weight,
        'url': url,
        //'time': time,
        'timeOfDay': timeOfDay,
      });

      print('Food added successfully for $date at $time.');
    } catch (e) {
      print('Failed to add food: $e');
    }
  }

  String Time(String time) {
    // Extract hour from time string
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);

    // Determine time of day based on the hour
    if (hour < 10) {
      return 'Breakfast';
    } else if (hour >= 10 && hour < 15)
      return 'Lunch';
    else if (hour >= 15 && hour < 18)
      return 'Snakcs';
    else if (hour >= 18 && hour < 20)
      return 'Supper';
    else
      return 'Dinner';
  }

  Future<List<FoodLite>> getFoodForCurrentDay() async {
    List<FoodLite> Foods = [];

    try {
      DateTime currentDate = DateTime.now();
      String date = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Food');

      // Retrieve all workouts for the current day
      QuerySnapshot querySnapshot = await dataCollection
          .doc(uid)
          .collection('dates')
          .doc(date)
          .collection('foods')
          .get();

      // Iterate over each document and create Workout objects
      querySnapshot.docs.forEach((doc) {
        String name = (doc.data() as Map<String, dynamic>)['name'] as String;
        int weight = (doc.data() as Map<String, dynamic>)['weight'] as int;
        String url = (doc.data() as Map<String, dynamic>)['url'] as String;
        String Timenow =
            (doc.data() as Map<String, dynamic>)['timeOfDay'] as String;
      });

      print('Retrieved ${Foods.length} workouts for $date.');
    } catch (e) {
      print('Failed to retrieve workouts: $e');
    }
    return Foods;
  }
}

class FoodLite {
  final String name;
  final double weight;
  final String url;
  final String timeOfDay;

  FoodLite(
      {required this.name,
      required this.weight,
      required this.url,
      required this.timeOfDay});
}
