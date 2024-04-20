import 'package:cloud_firestore/cloud_firestore.dart';

class CalorieService {
  final String uid;

  CalorieService({required this.uid});

  final CollectionReference userCaloriesCollection =
      FirebaseFirestore.instance.collection('calories');

  Future<void> addCaloriesForDate(
      DateTime date, int calories, int caloriesToBurn) async {
    try {
      //yyMMdd
      String formattedDate =
          "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";

      DocumentReference userDocument = userCaloriesCollection.doc(uid);

      bool documentExists = await userDocument.get().then((doc) => doc.exists);

      if (!documentExists) {
        await userDocument.set({});
      }

      await userDocument.collection('dates').doc(formattedDate).set({
        'calories': calories,
        'caloriesToBurn': caloriesToBurn,
      });

      print('Calories added successfully for $formattedDate');
    } catch (e) {
      print('Failed to add calories: $e');
    }
  }

  Future<Map<String, int>?> getCaloriesForDate(DateTime date) async {
    try {
      String formattedDate =
          "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";

      DocumentReference userDocument = userCaloriesCollection.doc(uid);
      DocumentSnapshot dateSnapshot =
          await userDocument.collection('dates').doc(formattedDate).get();
      if (dateSnapshot.exists) {
        int calories = dateSnapshot.get('calories') as int;
        int caloriesToBurn = dateSnapshot.get('caloriesToBurn') as int;
        return {'calories': calories, 'caloriesToBurn': caloriesToBurn};
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get calories: $e');
      return null;
    }
  }
}
