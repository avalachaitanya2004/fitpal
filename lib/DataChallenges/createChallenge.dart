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

  Future<void> Assign(String uid, String challengeId) async {
    try {
      // Get a reference to the Firestore collection "AssignedChallenges"
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('AssignedChallenges');

      CollectionReference<Map<String, dynamic>> challengesCollection =
          FirebaseFirestore.instance.collection('Challenges');

      // Get the document with the specified challengeId
      DocumentSnapshot<Map<String, dynamic>> challengeDocSnapshot =
          await challengesCollection.doc(challengeId).get();

      // Retrieve challenge details
      String name = challengeDocSnapshot.data()?['name'] ?? '';
      int days = challengeDocSnapshot.data()?['days'] ?? 0;
      String type = challengeDocSnapshot.data()?['type'] ?? '';
      int xp = challengeDocSnapshot.data()?['xp'] ?? 0;
      String challengeUid = challengeDocSnapshot.data()?['uid'] ?? '';

      // Set workout data in the "Assigned" subcollection
      await dataCollection
          .doc(uid)
          .collection('Assigned')
          .doc(challengeId)
          .set({
        'name': name,
        'days': days,
        'xp': xp,
        'type': type,
        'uid': challengeUid,
      });

      print('Workout added successfully.');
    } catch (e) {
      print('Failed to add workout: $e');
    }
  }

  Future<void> changeChallenges(String uid, String type) async {
    try {
      // Get a reference to the Firestore collection "CompletedChallenges"
      CollectionReference<Map<String, dynamic>> dataCollection =
          FirebaseFirestore.instance.collection('AssignedChallenges');

      // Get a reference to the "Assigned" subcollection for the specified user
      CollectionReference<Map<String, dynamic>> assignedCollection =
          dataCollection.doc(uid).collection('Assigned');

      // Retrieve documents from the "Assigned" subcollection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await assignedCollection.get();

      // Iterate over each document in the "Assigned" subcollection
      querySnapshot.docs.forEach((doc) async {
        // Check if the type matches the input parameter
        if (doc.data()['type'] == type) {
          // Decrease the number of days by one
          int currentDays = doc.data()['days'];
          int newDays = currentDays - 1;
          if (newDays == 0) {
            await assignedCollection.doc(doc.id).update({'days': newDays});
            await moveToAssignedChallenges(uid, doc);
          } else {
            await assignedCollection.doc(doc.id).update({'days': newDays});
          }
        }
      });

      print('Challenges updated successfully.');
    } catch (e) {
      print('Failed to update challenges: $e');
    }
  }

  Future<void> moveToAssignedChallenges(
      String uid, QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    try {
      CollectionReference<Map<String, dynamic>> dataCollection =
          FirebaseFirestore.instance.collection('CompletedChallenges');
      CollectionReference<Map<String, dynamic>> assignedCollection =
          dataCollection.doc(uid).collection('Assigned');

      // Add the document to the "Assigned" subcollection
      await assignedCollection.add(doc.data());

      // Delete the document from the "CompletedChallenges" subcollection
      await doc.reference.delete();
    } catch (e) {
      print('Failed to move document to AssignedChallenges: $e');
    }
  }
}
