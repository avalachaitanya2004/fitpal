import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future<void> addFriend(String currentUserUid, String friendUid) async {
    try {
      await usersCollection
          .doc(currentUserUid)
          .collection('friends')
          .doc(friendUid)
          .set({'uid': friendUid});
      await usersCollection
          .doc(friendUid)
          .collection('friends')
          .doc(currentUserUid)
          .set({'uid': currentUserUid});
    } catch (e) {
      print('Error adding friend: $e');
    }
  }

  Future<List<String>> getAllFriends(String currentUserUid) async {
    try {
      QuerySnapshot friendsSnapshot =
          await usersCollection.doc(currentUserUid).collection('friends').get();

      List<String> friendUids = [];
      friendsSnapshot.docs.forEach((doc) {
        friendUids.add(doc['uid']);
      });

      return friendUids;
    } catch (e) {
      print('Error getting friends: $e');
      return [];
    }
  }
}
