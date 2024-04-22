import 'package:cloud_firestore/cloud_firestore.dart';

class InitializeFoods {
  final String uid;

  InitializeFoods({required this.uid});

  Future<void> initializeFood() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('FoodURL');
      DateTime currentDate = DateTime.now();
      for (int i = 0; i < 60; i++) {
        // Calculate the date for the current iteration
        DateTime date = currentDate.add(Duration(days: i));

        // Construct the document ID using the date in yyyy-MM-dd format
        String documentId = date.toIso8601String().substring(0, 10);

        // Set the document data with integer and boolean variables for each day
        await dataCollection.doc(uid).collection('dates').doc(documentId).set({
          // Create an empty workout subcollection
          'workouts': [],
        });
      }
      print('Data initialized successfully.');
    } catch (e) {
      print('Failed to initialize data: $e');
    }
  }

  Future<void> addURL(String url) async {
    try {
      DateTime currentDate = DateTime.now();
      String date = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('FoodURL');

      // Add a new workout entry to the workouts subcollection
      await dataCollection
          .doc(uid)
          .collection('dates')
          .doc(date)
          .collection('URL')
          .add({
        'url': url,
      });

      print('Workout added successfully for $date.');
    } catch (e) {
      print('Failed to add workout: $e');
    }
  }
}
