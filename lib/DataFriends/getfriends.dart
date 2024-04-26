import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uid;
  final Map<String, String> statusMap;

  UserData({required this.uid, required this.statusMap});

  // Function to get list of user IDs where status is 'U'
  Future<List<String>> getUserIdsWithStatusU() async {
    try {
      List<String> userIds = [];

      // Query Firestore collection 'people' for the current user's document
      DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
          await FirebaseFirestore.instance.collection('people').doc(uid).get();

      if (currentUserDoc.exists) {
        // Get the 'users' field from the current user's document
        List<dynamic> usersList = currentUserDoc.data()!['users'];

        // Iterate over each user in the 'users' list
        usersList.forEach((userData) {
          // Check if the statusMap contains the status 'U' and it's true
          if (userData['statusMap'] != null &&
              userData['statusMap']['status'] == 'U') {
            userIds.add(userData['uid']);
          }
        });
      }

      return userIds;
    } catch (error) {
      print('Error getting user IDs with status U: $error');
      return [];
    }
  }

  // Function to get list of user IDs where status is 'F'
  Future<List<String>> getUserIdsWithStatusF() async {
    try {
      List<String> userIds = [];

      // Query Firestore collection 'people' for the current user's document
      DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
          await FirebaseFirestore.instance.collection('people').doc(uid).get();

      if (currentUserDoc.exists) {
        // Get the 'users' field from the current user's document
        List<dynamic> usersList = currentUserDoc.data()!['users'];

        // Iterate over each user in the 'users' list
        for (var userData in usersList) {
          // Check if the statusMap contains the status 'U' and it's true
          if (userData['statusMap'] != null &&
              userData['statusMap']['status'] == 'F') {
            userIds.add(userData['uid']);
          }
        }
      }

      return userIds;
    } catch (error) {
      print('Error getting user IDs with status U: $error');
      return [];
    }
  }

  Future<void> addUsersListToDatabase(String currentUserUID) async {
    try {
      List<Map<String, dynamic>> userList = [];

      // Get all documents from the 'initialize_data' collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('initialize_data').get();

      // Iterate over the documents to build the user list for the current user
      querySnapshot.docs.forEach((doc) {
        String otherUID = doc.id; // Get the UID of the other user
        if (otherUID != currentUserUID) {
          // If the UID is not the current user's UID
          Map<String, dynamic> userData = {
            'uid': otherUID,
            'statusMap': {
              'status': 'U'
            } // Initialize status to 'U' for all users
          };
          userList.add(userData);
        }
      });

      // Get the existing status of users from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await FirebaseFirestore.instance
              .collection('people')
              .doc(currentUserUID)
              .get();

      if (userDocument.exists) {
        // If the document exists, check and update status if necessary
        List<Map<String, dynamic>> existingUserList =
            List<Map<String, dynamic>>.from(
                userDocument.data()!['users'] ?? []);

        // Iterate through existing users and update status if it's 'F'
        existingUserList.forEach((user) {
          if (user['statusMap']['status'] == 'F') {
            // If the status is 'F', keep it as 'F'
            userList.firstWhere(
                    (newUser) => newUser['uid'] == user['uid'])['statusMap']
                ['status'] = 'F';
          }
        });
      }

      // Add userList to Firestore under collection 'people' with document ID as currentUserUID
      await FirebaseFirestore.instance
          .collection('people')
          .doc(currentUserUID)
          .set({'users': userList});

      print('User list added to Firestore successfully');
    } catch (error) {
      print('Error adding user list to Firestore: $error');
    }
  }

  Future<void> updateFriendStatus(String currentUid, String friendUid) async {
    try {
      // Get the document of the current user from Firestore
      DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
          await FirebaseFirestore.instance
              .collection('people')
              .doc(currentUid)
              .get();

      if (currentUserDoc.exists) {
        // Get the 'users' field from the current user's document
        List<dynamic> usersList = currentUserDoc.data()!['users'];

        // Find the index of the friend in the 'usersList'
        int friendIndex =
            usersList.indexWhere((userData) => userData['uid'] == friendUid);

        if (friendIndex != -1) {
          // Update the status of the friend to 'F' in the statusMap
          Map<String, dynamic> statusMap = usersList[friendIndex]['statusMap'];
          statusMap['status'] = 'F';

          // Update the Firestore document with the modified 'users' list
          await FirebaseFirestore.instance
              .collection('people')
              .doc(currentUid)
              .update({
            'users': usersList,
          });

          print('Friend status updated successfully');

          // Now update the friend's document with the current user's status
          DocumentSnapshot<Map<String, dynamic>> friendDoc =
              await FirebaseFirestore.instance
                  .collection('people')
                  .doc(friendUid)
                  .get();

          if (friendDoc.exists) {
            List<dynamic> friendUsersList = friendDoc.data()!['users'];
            int currentUserIndex = friendUsersList
                .indexWhere((userData) => userData['uid'] == currentUid);

            if (currentUserIndex != -1) {
              Map<String, dynamic> currentUserStatusMap =
                  friendUsersList[currentUserIndex]['statusMap'];
              currentUserStatusMap['status'] = 'F';

              // Update the Firestore document with the modified 'users' list for the friend
              await FirebaseFirestore.instance
                  .collection('people')
                  .doc(friendUid)
                  .update({
                'users': friendUsersList,
              });

              print('Friend\'s status updated successfully');
            } else {
              print('Current user not found in the friend\'s list');
            }
          } else {
            print('Friend document not found for UID: $friendUid');
          }
        } else {
          print('Friend with UID $friendUid not found in the user\'s list');
        }
      } else {
        print('User document not found for UID: $currentUid');
      }
    } catch (error) {
      print('Error updating friend status: $error');
    }
  }
}
