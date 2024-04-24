import 'package:cloud_firestore/cloud_firestore.dart';

class Createchallenge {
  final CollectionReference challengesCollection =
      FirebaseFirestore.instance.collection('Challenges');

  Future<void> create(String Type, String name, int days, int xp, String uid) {
    return challengesCollection
        .add({'type': Type, 'name': name, 'days': 30, 'xp': xp, 'uid': uid});
  }

  Future<List<Map<String, dynamic>>> processChallengeDocuments() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference<Map<String, dynamic>> challengesCollection =
          FirebaseFirestore.instance.collection('Challenges');

      // Retrieve all documents from the collection
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await challengesCollection.get();

      List<Map<String, dynamic>> challengeDataList = [];

      // Process each document
      snapshot.docs.forEach((doc) {
        String type = doc.data()['type'] as String;
        String name = doc.data()['name'] as String;
        int days = doc.data()['days'] as int;
        int xp = doc.data()['xp'] as int;
        String uid = doc.data()['uid'] as String;

        // Create a map to store document data
        Map<String, dynamic> challengeData = {
          'type': type,
          'name': name,
          'days': days,
          'xp': xp,
          'uid': uid,
        };

        // Add the document data to the list
        challengeDataList.add(challengeData);
      });

      print('All challenge documents processed successfully.');
      return challengeDataList;
    } catch (error) {
      print('Error processing challenge documents: $error');
      return [];
    }
  }

  Future<void> assignChallenge(String uid, String challengeId) async {
    try {
      // Get a reference to the Firestore collection "Challenges"
      CollectionReference challengesCollection =
          FirebaseFirestore.instance.collection('Challenges');

      // Query Firestore to find the document with the specified challengeId
      DocumentSnapshot challengeSnapshot =
          await challengesCollection.doc(challengeId).get();

      // Check if the document exists
      if (challengeSnapshot.exists) {
        // Extract the challenge data from the snapshot
        var challengeData = challengeSnapshot.data()!;

        // Get a reference to the Firestore collection "assignedChallenges"
        CollectionReference assignedChallengesCollection =
            FirebaseFirestore.instance.collection('assignedChallenges');

        // Add a document with the user's UID as the document ID
        await assignedChallengesCollection.doc(uid).set({
          'challengeData': challengeData, // Store the challenge data
          // You can store additional details of the assigned challenge here if needed
        });

        print('Challenge assigned successfully.');
      } else {
        print('Challenge with ID $challengeId not found.');
      }
    } catch (e) {
      print('Error assigning challenge: $e');
    }
  }
}
