import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/exerciseData.dart';
import 'package:fit_pal/models/exerciseselect_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<ExerciseCard> exercises = List.generate(
    16,
    (index) => ExerciseCard(
      name: [
        'JUMPING JACKS',
        'ABDOMINAL CRUNCHES',
        'RUSSIAN TWIST',
        'MOUNTAIN CLIMBER'
      ][index % 4],
      defaultreps: [10, 20, 15, 10][index % 4],
      repsWanted: [10, 20, 15, 10][index % 4],
      isSelected: false,
    ),
  );
  List<Excersise> selectedExercises = [];
  List<ExerciseCard> foundExercises = [];

  @override
  void initState() {
    super.initState();
    foundExercises = exercises;
  }

  void filter(String value) {
    setState(() {
      foundExercises = value.isEmpty
          ? exercises
          : exercises
              .where((card) =>
                  card.name.toLowerCase().contains(value.toLowerCase()))
              .toList();
    });
  }

  void updateExercise(ExerciseCard updatedExercise) {
    int index =
        exercises.indexWhere((element) => element.name == updatedExercise.name);
    if (index != -1) {
      setState(() {
        exercises[index] = updatedExercise;
        if (updatedExercise.isSelected) {
          Excersise temp = Excersise(
              name: updatedExercise.name, reps: updatedExercise.repsWanted);
          selectedExercises.add(temp);
        } else {
          int index = selectedExercises
              .indexWhere((element) => element.name == updatedExercise.name);
          selectedExercises.removeAt(index);
        }
      });
    }
  }

  bool selected() {
    bool bo = false;
    for (var i = 0; i < exercises.length; i++) {
      if (exercises[i].isSelected) {
        bo = true;
      }
    }
    return bo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Playlist"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.4),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    focusNode: focusNode,
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    onChanged: filter,
                    decoration: const InputDecoration(
                      labelText: "Search",
                      suffixIcon: Icon(Icons.search),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                if (selected())
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 15, 20, 5),
                        child: Text(
                          'Selected Exercises',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )),
                ...exercises
                    .where((exercise) => exercise.isSelected)
                    .map((exercise) => ExcerciseSelectCard(
                          excersise: exercise,
                          onUpdateExercise: updateExercise,
                        ))
                    .toList(),
                if (selected()) const Divider(),
                // SizedBox(height: nothingSelected() ? 20 : 0),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 10, 20, 5),
                      child: Text(
                        'Available Exercises',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )),
                ...foundExercises
                    .where((exercise) => !(exercise.isSelected))
                    .map((exercise) => ExcerciseSelectCard(
                          excersise: exercise,
                          onUpdateExercise: updateExercise,
                        )),
              ],
            ),
          ),
          if (selected())
            Positioned(
              bottom: 20,
              right: 20,
              // child: Container(
              // width: 75,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                // mini: true,
                backgroundColor: Colors.white,
                onPressed: () {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  final uid = currentUser?.uid;
                  Dataservices dataservices = Dataservices(uid: uid.toString());
                  for (var exercise in selectedExercises) {
                    // Call the CustomWorkout function for each exercise
                    dataservices.CustomWorkout(nameController.text.trim(),
                        exercise.name, exercise.reps);
                  }
                },
                child: const Icon(
                  Icons.check,
                  size: 30,
                ),
                // child: Text(
                //   "Create",
                //   style: TextStyle(
                //     fontFamily: 'Roboto',
                //     fontSize: 15,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ),
              // ),
            ),
        ],
      ),
    );
  }
}
