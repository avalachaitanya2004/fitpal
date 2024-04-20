import 'package:cloud_firestore/cloud_firestore.dart';

class Exp {
  final String uid;

  Exp({required this.uid});

  Future<void> storeUserXP(int xp) async {
    try {
      await FirebaseFirestore.instance
          .collection('Experiencepoints')
          .doc(uid)
          .set({
        'xp': xp,
      }, SetOptions(merge: true));
      print('User XP stored successfully.');
    } catch (e) {
      print('Error storing user XP: $e');
    }
  }
}
