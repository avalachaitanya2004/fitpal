import 'package:cloud_firestore/cloud_firestore.dart';
import 'exppoints.dart';

class ChallengeComp {
  final String uid;

  ChallengeComp({required this.uid});

  Future<void> completeChallenge(String challengeId, int xp) async {
    try {
      // Delete the challenge with the specified UID
      await FirebaseFirestore.instance
          .collection('assigned_challenges')
          .doc(uid)
          .collection('challenges')
          .doc(challengeId)
          .delete();

      // Add XP to user's XP in the 'Experiencepoints' collection
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('Experiencepoints').doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();
      int currentXP = userDoc.exists ? (userDoc.data()?['xp'] ?? 0) : 0;
      int updatedXP = currentXP + xp;

      await userDocRef.set({'xp': updatedXP}, SetOptions(merge: true));

      print('Challenge completed successfully.');
    } catch (e) {
      print('Error completing challenge: $e
