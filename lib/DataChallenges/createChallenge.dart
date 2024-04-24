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
