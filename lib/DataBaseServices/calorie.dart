import 'package:cloud_firestore/cloud_firestore.dart';

class CalorieService {
  final String uid;

  CalorieService({required this.uid});

  Future<void> addCaloriesForCurrentDate(int caloriesToBurn) async {
    try {
      DateTime currentDate = DateTime.now();
      String formattedDate =
          "${currentDate.year}${currentDate.month.toString().padLeft(2, '0')}${currentDate.day.toString().padLeft(2, '0')}";

      // Get a reference to the user's document
      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('UserCalories').doc(uid);

      // Add the calories for the current date
      await userDocument.collection('dates').doc(formattedDate).set({
        'caloriesToBurn': caloriesToBurn,
      });

      print('Calories added successfully for $formattedDate');
    } catch (e) {
      print('Failed to add calories: $e');
    }
  }

  Future<void> decrementCaloriesForCurrentDate(int caloriesToDecrement) async {
    try {
      DateTime currentDate = DateTime.now();
      String formattedDate =
          "${currentDate.year}${currentDate.month.toString().padLeft(2, '0')}${currentDate.day.toString().padLeft(2, '0')}";

      // Get a reference to the user's document
      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('UserCalories').doc(uid);

      // Get the current calories document for the current date
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await userDocument.collection('dates').doc(formattedDate).get();

      // Check if the document exists
      if (snapshot.exists) {
        int currentCaloriesToBurn = snapshot.data()?['caloriesToBurn'] ?? 0;
        int updatedCaloriesToBurn =
            (currentCaloriesToBurn - caloriesToDecrement)
                .clamp(0, double.infinity)
                .toInt();

        // Update the calories for the current date
        await userDocument.collection('dates').doc(formattedDate).update({
          'caloriesToBurn': updatedCaloriesToBurn,
        });

        print('Calories decremented successfully for $formattedDate');
      } else {
        print('No calories document found for $formattedDate');
      }
    } catch (e) {
      print('Failed to decrement calories: $e');
    }
  }

  Future<Map<String, int>?> getCaloriesForDate(String Date) async {
    try {
      // Get a reference to the user's document
      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('UserCalories').doc(uid);

      // Get the document snapshot for the specified date
      DocumentSnapshot<Map<String, dynamic>> dateSnapshot =
          await userDocument.collection('dates').doc(Date).get();

      // Check if the document exists
      if (dateSnapshot.exists) {
        int caloriesToBurn = dateSnapshot.data()?['caloriesToBurn'] ?? 0;
        return {'caloriesToBurn': caloriesToBurn};
      } else {
        print('No calories document found for');
        return null;
      }
    } catch (e) {
      print('Failed to get calories: $e');
      return null;
    }
  }
}
