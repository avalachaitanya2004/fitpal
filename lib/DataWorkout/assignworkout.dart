import 'package:fit_pal/models/custom_workouts.dart';
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
      // Get the current date
      DateTime currentDate = DateTime.now();
      String date = currentDate.toIso8601String().substring(0, 10);

      // Get a reference to the Firestore collection "Workout"
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('Workout');

      // Update the "workouts" subcollection inside the specified document
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

      print('Workout added successfully.');
    } catch (e) {
      print('Failed to add workout: $e');
    }
  }

  Future<void> playlist(
      List<String> playlistNames, List<Excersise> selectedExercises) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a map to store the exercises
      List<Map<String, dynamic>> exercisesList =
          selectedExercises.map((exercise) {
        return {
          'name': exercise.name,
          'reps': exercise.reps,
          'bool':
              false // You may need to adjust this value based on your requirements
        };
      }).toList();

      // Create a map to store playlist names and their respective exercises
      Map<String, dynamic> playlistsMap = {};
      for (var playlistName in playlistNames) {
        playlistsMap[playlistName] = {
          'exercises': FieldValue.arrayUnion(exercisesList)
        };
      }

      // Add the map of playlists to the Firestore document
      await firestore
          .collection('CustomWorkout')
          .doc(uid)
          .set({'playlists': playlistsMap}, SetOptions(merge: true));

      print('Playlists added successfully!');
    } catch (error) {
      print('Error adding playlists: $error');
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>>
      getPlaylistsAndExercises() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the document containing the playlists from Firestore
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await firestore.collection('CustomWorkout').doc(uid).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Get the data from the document
        Map<String, dynamic> data = docSnapshot.data()!;
        // Get the playlists map from the data
        Map<String, dynamic> playlistsMap = data['playlists'] ?? {};

        // Initialize the result map
        Map<String, List<Map<String, dynamic>>> result = {};

        // Iterate over each playlist in the playlists map
        playlistsMap.forEach((playlistName, playlistData) {
          // Get the exercises list for the current playlist
          List<Map<String, dynamic>> exercises =
              List<Map<String, dynamic>>.from(playlistData['exercises'] ?? []);
          // Add the playlist and its exercises to the result map
          result[playlistName] = exercises;
        });

        return result;
      } else {
        print('Document not found for user ID: $uid');
        return {};
      }
    } catch (error) {
      print('Error fetching playlists and exercises: $error');
      return {};
    }
  }

  List<CustomPlaylist> convertMapToCustomPlaylist(
      Map<String, List<Map<String, dynamic>>> playlistsAndExercises) {
    List<CustomPlaylist> customPlaylists = [];
    playlistsAndExercises.forEach((playlistName, exercisesList) {
      List<Excersise> exercises = [];

      for (var exerciseData in exercisesList) {
        String name = exerciseData['name'];
        int reps = exerciseData['reps'];

        exercises.add(Excersise(name: name, reps: reps));
      }
      customPlaylists.add(CustomPlaylist(name: playlistName, set: exercises));
    });
    return customPlaylists;
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
