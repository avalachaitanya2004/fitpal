import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_pal/DataWorkout/assignworkout.dart';

class Workout {
  final String name;
  final int reps;

  Workout({required this.name, required this.reps});
}

class InitializeWorkout {
  final String uid;

  InitializeWorkout({required this.uid});

  Future<void> initializeWorkoutAssign() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Workout');
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

  Future<void> addWorkout(String name, int reps) async {
    try {
      DateTime currentDate = DateTime.now();
      String date = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Workout');

      // Add a new workout entry to the workouts subcollection
      await dataCollection
          .doc(uid)
          .collection('dates')
          .doc(date)
          .collection('workouts')
          .add({
        'name': name,
        'reps': reps,
        'bool': false,
      });

      print('Workout added successfully for $date.');
    } catch (e) {
      print('Failed to add workout: $e');
    }
  }

  Future<void> triggerBool(String inputName) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Workout');

      QuerySnapshot querySnapshot = await dataCollection
          .doc(uid)
          .collection('dates')
          .doc(DateTime.now().toIso8601String().substring(0, 10))
          .collection('workouts')
          .get();

      querySnapshot.docs.forEach((doc) {
        String? name =
            (doc.data() as Map<String, dynamic>?)?['name'] as String?;
        bool boolValue = name == inputName;
        doc.reference.update({'bool': boolValue});
      });

      print('Bool triggered successfully.');
    } catch (e) {
      print('Failed to trigger bool: $e');
    }
  }

  Future<List<Workout>> getWorkoutsForCurrentDay() async {
    List<Workout> workouts = [];
    try {
      DateTime currentDate = DateTime.now();
      String date = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Workout');

      // Retrieve all workouts for the current day
      QuerySnapshot querySnapshot = await dataCollection
          .doc(uid)
          .collection('dates')
          .doc(date)
          .collection('workouts')
          .get();

      // Iterate over each document and create Workout objects
      querySnapshot.docs.forEach((doc) {
        String name = (doc.data() as Map<String, dynamic>)['name'] as String;
        int reps = (doc.data() as Map<String, dynamic>)['reps'] as int;

        workouts.add(Workout(name: name, reps: reps));
      });

      print('Retrieved ${workouts.length} workouts for $date.');
    } catch (e) {
      print('Failed to retrieve workouts: $e');
    }
    return workouts;
  }
}
