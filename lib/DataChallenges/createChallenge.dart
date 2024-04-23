import 'package:cloud_firestore/cloud_firestore.dart';

class Createchallenge {
  final CollectionReference challengesCollection =
      FirebaseFirestore.instance.collection('Challenges');

  Future<void> create(String Type, String name, int days, int xp, String uid) {
    return challengesCollection
        .add({'type': Type, 'name': name, 'days': 30, 'xp': xp, 'uid': uid});
  }
}

class AssignChallenge {
  final String uid;
  AssignChallenge({required this.uid});

  Future<void> assign(String challengeId) async {
    try {
      final CollectionReference challengesCollection =
          FirebaseFirestore.instance.collection('AssignedChallenges');

      DocumentReference userDocRef = challengesCollection.doc(uid);

      DocumentSnapshot challengeSnapshot = await FirebaseFirestore.instance
          .collection('Challenges')
          .doc(challengeId)
          .get();

      if (challengeSnapshot.exists) {
        // Get the challenge data and explicitly cast it to Map<String, dynamic>
        Map<String, dynamic> challengeData =
            challengeSnapshot.data() as Map<String, dynamic>;

        // Update the document to add the assigned challenge with its details
        await userDocRef.set(
          {
            'challenges': FieldValue.arrayUnion([
              {
                'id': challengeId,
                'name': challengeData['name'],
                'type': challengeData['type'],
                'days': challengeData['days'],
                'xp': challengeData['xp'],
                // Add more challenge details as needed
              }
            ]),
          },
          SetOptions(
              merge: true), // Use merge option to not overwrite existing data
        );

        print('Challenge assigned successfully.');
      } else {
        print('Challenge with ID $challengeId does not exist.');
      }
    } catch (error) {
      print('Error assigning challenge: $error');
    }
  }
}
