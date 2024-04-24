// import 'dart:js_interop_unsafe';

import 'package:bounce_tap/bounce_tap.dart';
import 'package:fit_pal/models/excercise_info.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/exerciseData.dart';
import 'package:fit_pal/models/select_exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExcerciseSelectCard extends StatefulWidget {
  const ExcerciseSelectCard(
      {super.key, required this.excersise, required this.onUpdateExercise});
  final ExerciseCard excersise;
  final Function(ExerciseCard) onUpdateExercise;

  @override
  State<ExcerciseSelectCard> createState() => _ExcerciseSelectCardState();
}

class _ExcerciseSelectCardState extends State<ExcerciseSelectCard> {
  String? ImagePath(String name) {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['image'] as String?;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // picture
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 80,
                // color: Colors.getProperty(property),
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage(
                          ImagePath(widget.excersise.name) ?? 'null')),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150, // Set a maximum width based on your layout needs
                  child: Text(
                    widget.excersise.name.capitalize(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (widget.excersise.isSelected)
                  Text(
                    'x ${widget.excersise.repsWanted}',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                else
                  Text(
                    'x ${widget.excersise.defaultreps}',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
              ],
            ),
            Spacer(),
            if (!widget.excersise.isSelected)
              Container(
                height: 0.1 * (MediaQuery.of(context).size.width),
                width: 0.1 * (MediaQuery.of(context).size.width),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SelectExercise(
                            excersise: widget.excersise,
                            onUpdateExercise: (updatedExercise) {
                              widget.onUpdateExercise(updatedExercise);
                            },
                          );
                        });
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  shape: CircleBorder(),
                  backgroundColor: Colors.grey[50],
                  foregroundColor: Colors.black54,
                ),
              )
            else
              Container(
                height: 0.1 * (MediaQuery.of(context).size.width),
                width: 0.1 * (MediaQuery.of(context).size.width),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    widget.onUpdateExercise(ExerciseCard(
                        name: widget.excersise.name,
                        defaultreps: widget.excersise.defaultreps,
                        repsWanted: widget.excersise.defaultreps,
                        isSelected: false,
                        ismin: widget.excersise.ismin));
                  },
                  child: Icon(
                    Icons.remove,
                    size: 30,
                  ),
                  shape: CircleBorder(),
                  backgroundColor: Colors.grey[50],
                  foregroundColor: Colors.black54,
                ),
              ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return "";
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}
