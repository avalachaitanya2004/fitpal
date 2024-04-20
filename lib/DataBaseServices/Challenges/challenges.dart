import 'package:cloud_firestore/cloud_firestore.dart';

class Challenges {
  Future<void> uploadChallenge(String nameOfChallenge, int xp) async {
    try {
      await FirebaseFirestore.instance.collection('challenges').add({
        'name': nameOfChallenge,
        'xp': xp,
      });
      print('Challenge uploaded successfully.');
    } catch (e) {
      print('Error uploading challenge: $e');
    }
  }
}

//food and workout 

//variable : tym period in days

//delete challenge normally when not completed completely
