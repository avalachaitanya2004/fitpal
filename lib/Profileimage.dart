import 'package:cloud_firestore/cloud_firestore.dart';

class Profilepage {
  final String uid;
  Profilepage({required this.uid});

  // Reference to the collection
  CollectionReference<Map<String, dynamic>> get collectionReference =>
      FirebaseFirestore.instance.collection('ProfileLink');

  Future<void> setProfileLink(String link) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('ProfileLink');
      await collectionReference.doc(uid).set({
        'link': link,
      });
      print('Profile link set successfully for UID: $uid');
    } catch (e) {
      print('Failed to set profile link: $e');
    }
  }

  Future<String?> getProfileLink() async {
    try {
      // Get the document reference with the provided UID
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('ProfileLink').doc(uid);

      // Get the snapshot of the document
      DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference
          .get() as DocumentSnapshot<Map<String, dynamic>>;

      // Check if the document exists
      if (snapshot.exists) {
        // Retrieve the link value from the document
        String? link = snapshot.data()?['link'];

        // Additional null check for 'link'
        if (link != null) {
          print('Profile link retrieved successfully: $link');
          return link;
        } else {
          // Handle the case where 'link' is null
          print('Profile link is null for UID: $uid');
          return null;
        }
      } else {
        // Document does not exist
        print('Document does not exist for UID: $uid');
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Failed to get profile link: $e');
      return null;
    }
  }
}
