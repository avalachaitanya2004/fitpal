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
}
