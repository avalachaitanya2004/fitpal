import 'package:cloud_firestore/cloud_firestore.dart';

class Assignchallenge {
  Future<void> assignChallengeToUser(String challengeId, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('assigned_challenges')
          .doc(userId)
          .set({
        'challengeId': challengeId,
      });
      print('Challenge assigned to user successfully.');
    } catch (e) {
      print('Error assigning challenge to user: $e');
    }
  }

  Future<List<String>> getAssignedChallengesForUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('assigned_challenges')
          .where('userId', isEqualTo: userId)
          .get();

      List<String> assignedChallenges = [];
      querySnapshot.docs.forEach((doc) {
        assignedChallenges.add(doc.get('challengeId'));
      });

      return assignedChallenges;
    } catch (e) {
      print('Error fetching assigned challenges: $e');
      return [];
    }
  }
}

//profile ---- small work 

//leadrboard sort the xp for only one week  -- xp calculate per week for each person

//streak variable maintain it for all the days if gone remove it claorie workout and streak  --- difficult 

//health kit flutter steps and heart rate 

//active energy burned , blood o2 , heart rate , steps  

//workouts display by date each workout for only one day 

//water storage for user manual input and decrease based on user and gets xp 
