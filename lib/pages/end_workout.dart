import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndWorkout extends StatelessWidget {
  const EndWorkout({super.key, required this.XP});
  final int XP;

  Future<void> addXPToSpecificDate() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    String userId = user!.uid;
    final firestoreInstance = FirebaseFirestore.instance;
    // Get the current XP value for the specified date
    String date = DateTime.now().toIso8601String().substring(0, 10);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestoreInstance.collection('XP').doc(userId).get();
    Map<String, dynamic> xpData = documentSnapshot.data() ?? {};

    // Get the current XP value for the specified date
    int currentXP = xpData[date] ?? 0;

    // Calculate the new XP value by adding the XP to be added
    int newXP = currentXP + XP;

    // Update Firestore with the new XP value for the specified date
    xpData[date] = newXP;
    await firestoreInstance.collection('XP').doc(userId).set(xpData);
  }

//   Dataservices data = Dataservices(uid: uid)

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('Congrats you have completed ur workouts'),
    //       ElevatedButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('Done'))
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 278,
              width: 278,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Success.png'),
                  scale: 2.0,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              'Exercise Completed',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            Text(
              'Yaay!! You are rocking today',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                addXPToSpecificDate();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                height: 55,
                width: MediaQuery.sizeOf(context).width * 0.8,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
