import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InitializationController extends StatefulWidget {
  const InitializationController({super.key});

  @override
  State<InitializationController> createState() =>
      _InitializationControllerState();
}

class _InitializationControllerState extends State<InitializationController> {
  late String userId;
  late String? check;

  Future<String?> getCheckValue() async {
    try {
      CollectionReference<Map<String, dynamic>> initializedataCollection =
          FirebaseFirestore.instance.collection('initialize_data');

      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await initializedataCollection.doc(userId).get();

      if (userSnapshot.exists &&
          userSnapshot.data() != null &&
          userSnapshot.data()!.containsKey('count')) {
        return userSnapshot.data()!['count'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting check value: $e');
      return null;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    final User? user = _auth.currentUser;
    userId = user!.uid;

    // print(check);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCheckValue().then((value) {
      setState(() {
        check = value; // Assign the result to check after it's fetched
        print(check);
      });
    });
    return Scaffold();
  }
}
