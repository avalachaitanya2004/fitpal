import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dataservices {
  final String uid;
  Dataservices({required this.uid});

  Future<void> initializeWater({
    required int target,
    required double quantity,
  }) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('water');
      await dataCollection.doc(uid).set({
        'target': target,
        'quantity': quantity,
      });
      print('Data initialized successfully.');
    } catch (e) {
      print('Failed to initialize data: $e');
    }
  }

  Future<void> StreakandWater() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('StreakandWater');
      DateTime currentDate = DateTime.now();
      for (int i = 0; i < 60; i++) {
        // Calculate the date for the current iteration
        DateTime date = currentDate.add(Duration(days: i));

        // Construct the document ID using the date in yyyy-MM-dd format
        String documentId = date.toIso8601String().substring(0, 10);

        // Set the document data with integer and boolean variables for each day
        await dataCollection.doc(uid).collection('dates').doc(documentId).set({
          'waterintake':
              0, // Initial integer value (you can set it to any initial value)
          'streak':
              false, // Initial boolean value (you can set it to any initial value)
        });
      }
      // await dataCollection.doc(uid).set({

      // });
      print('Data initialized successfully.');
    } catch (e) {
      print('Failed to initialize data: $e');
    }
  }

  Future<void> updateTarget(int newTarget) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('water');
      await dataCollection.doc(uid).update({'target': newTarget});
      print('Target updated successfully.');
    } catch (e) {
      print('Failed to update target: $e');
    }
  }

  Future<void> updateQuantity(int newQuantity) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('water');
      await dataCollection.doc(uid).update({'quantity': newQuantity});
      print('Quantity updated successfully.');
    } catch (e) {
      print('Failed to update quantity: $e');
    }
  }

  Future<void> updateComplete(int complete) async {
    try {
      // Get the current date
      DateTime currentDate = DateTime.now();

      // Convert the date to yyyy-MM-dd format to construct the document ID
      String documentId = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('StreakandWater');

      // Get the document reference for the specified date
      DocumentReference documentRef =
          dataCollection.doc(uid).collection('dates').doc(documentId);

      // Get the current water intake value from the document
      // Increment the water intake by one
      int updatedWaterIntake = complete;

      // Update the 'waterintake' field for today's date
      await documentRef.set({'waterintake': updatedWaterIntake});

      print('Water intake updated successfully for $documentId.');
    } catch (e) {
      print('Failed to update water intake: $e');
    }
  }

  Future<void> updateWaterIntakebyOne() async {
    try {
      // Get the current date
      DateTime currentDate = DateTime.now();

      // Convert the date to yyyy-MM-dd format to construct the document ID
      String documentId = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('StreakandWater');

      // Get the document reference for the specified date
      DocumentReference documentRef =
          dataCollection.doc(uid).collection('dates').doc(documentId);

      // Get the current water intake value from the document
      DocumentSnapshot documentSnapshot = await documentRef.get();
      int currentWaterIntake = (documentSnapshot.data()
              as Map<String, dynamic>?)?['waterintake'] as int? ??
          0;
      // Increment the water intake by one
      int updatedWaterIntake = currentWaterIntake + 1;

      // Update the 'waterintake' field for today's date
      await documentRef.set({'waterintake': updatedWaterIntake});

      print('Water intake updated successfully for $documentId.');
    } catch (e) {
      print('Failed to update water intake: $e');
    }
  }

  Future<void> updateWaterIntakebySubOne() async {
    try {
      // Get the current date
      DateTime currentDate = DateTime.now();

      // Convert the date to yyyy-MM-dd format to construct the document ID
      String documentId = currentDate.toIso8601String().substring(0, 10);

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('StreakandWater');

      // Get the document reference for the specified date
      DocumentReference documentRef =
          dataCollection.doc(uid).collection('dates').doc(documentId);

      // Get the current water intake value from the document
      DocumentSnapshot documentSnapshot = await documentRef.get();
      int currentWaterIntake = (documentSnapshot.data()
              as Map<String, dynamic>?)?['waterintake'] as int? ??
          0;
      // Increment the water intake by one
      int updatedWaterIntake = currentWaterIntake - 1;

      // Update the 'waterintake' field for today's date
      await documentRef.set({'waterintake': updatedWaterIntake});

      print('Water intake updated successfully for $documentId.');
    } catch (e) {
      print('Failed to update water intake: $e');
    }
  }

  Future<void> initializeData({
    required String name,
    required int age,
    required String gender,
    required int height,
    required double weight,
    required int check,
    required int count,
    required int goal,
  }) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('initialize_data');
      await dataCollection.doc(uid).set({
        'name': name,
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
        'check': check,
        'count': count,
        'goal': goal,
      });
      print('Data initialized successfully.');
    } catch (e) {
      print('Failed to initialize data: $e');
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('initialize_data')
          .doc(uid)
          .get();

      User? user = FirebaseAuth.instance.currentUser;

      if (snapshot.exists && user != null) {
        String? name = snapshot.data()?['name'] as String?;
        dynamic weightData = snapshot.data()?['weight']; // Retrieve weight data
        dynamic heightData = snapshot.data()?['height'];

        // Parse weight data to double if it's not null
        double? weight =
            weightData != null ? (weightData as num).toDouble() : null;
        int? height = heightData != null ? (heightData as num).toInt() : null;

        String? email = user.email;
        return {
          'name': name,
          'email': email,
          'weight': weight,
          'height': height
        };
      } else {
        return {};
      }
    } catch (e) {
      print('Error getting user info: $e');
      return {};
    }
  }

  Future<void> updateName(String newName) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('initialize_data');
      await dataCollection.doc(uid).update({'name': newName});
      print('Name updated successfully.');
    } catch (e) {
      print('Failed to update name: $e');
    }
  }

  Future<void> CustomWorkout(
      String Playlist, String exerciseName, int reps) async {
    try {
      // Reference to Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user's ID
      final currentUser = FirebaseAuth.instance.currentUser;
      final userId = currentUser?.uid;

      // Reference to the CustomWorkout collection
      CollectionReference<Map<String, dynamic>> customWorkoutCollection =
          firestore.collection('CustomWorkout');

      // Add a new document to the CustomWorkout collection
      DocumentReference<Map<String, dynamic>> workoutDocRef =
          customWorkoutCollection.doc(userId);

      // Reference to the Playlist sub-collection inside the CustomWorkout collection
      CollectionReference<Map<String, dynamic>> playlistCollection =
          workoutDocRef.collection(Playlist);

      // Add the exercise and reps to the Playlist sub-collection
      await playlistCollection.add({
        'exerciseName': exerciseName,
        'reps': reps,
        'bool': false,
      });

      print('Exercise added successfully to the custom workout playlist!');
    } catch (e) {
      print('Error adding exercise to custom workout: $e');
    }
  }
}
