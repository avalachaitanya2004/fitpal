import 'package:cloud_firestore/cloud_firestore.dart';

class Exp {
  final String uid;

  Exp({required this.uid});

  final CollectionReference expCollection =
      FirebaseFirestore.instance.collection('Experience points');

  Future<void> addExperience(int xp, int wxp) async {
    await expCollection.doc(uid).set({
      'xp': xp,
      'week_xp': wxp,
    });
  }
}
