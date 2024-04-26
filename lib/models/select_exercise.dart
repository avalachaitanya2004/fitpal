import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:fit_pal/models/excercise_info.dart';
import 'package:fit_pal/models/excercises.dart';
import 'package:fit_pal/models/exerciseData.dart';
import 'package:fit_pal/models/selectExercise_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class SelectExercise extends StatefulWidget {
  const SelectExercise(
      {Key? key, required this.excersise, required this.onUpdateExercise})
      : super(key: key);
  final Function(ExerciseCard) onUpdateExercise;
  final ExerciseCard excersise;

  @override
  State<SelectExercise> createState() => _SelectExerciseState();
}

class _SelectExerciseState extends State<SelectExercise> {
  late int currentValue;
  late TextEditingController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    currentValue = widget.excersise.defaultreps;
    _controller = TextEditingController(text: currentValue.toString());
    _controller.addListener(() {
      final int? newReps = int.tryParse(_controller.text);
      if (newReps != null && newReps != currentValue) {
        setState(() {
          currentValue = newReps;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white60),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomSlidingSegmentedControl<int>(
                  isStretch: true,
                  initialValue: _page,
                  children: {
                    0: Text('Description', style: _textStyle(0)),
                    1: Text('Add', style: _textStyle(1)),
                  },
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                  onValueChanged: (int v) {
                    setState(() {
                      _page = v;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              if (_page == 0)
                SelectedExcerciseInfo(exersise: widget.excersise)
              else
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.excersise.ismin
                                ? Text("Number of seconds: ",
                                    style: TextStyle(color: Colors.black))
                                : Text("Number of reps: ",
                                    style: TextStyle(color: Colors.black)),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline,
                                      color: Colors.black),
                                  onPressed: () {
                                    int newValue =
                                        currentValue > 0 ? currentValue - 1 : 0;
                                    _controller.text = newValue.toString();
                                    setState(() {
                                      currentValue = newValue;
                                    });
                                  },
                                ),
                                Container(
                                  width:
                                      25, // Set the width of the TextField to 25
                                  child: TextField(
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      hintText: "",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline,
                                      color: Colors.black),
                                  onPressed: () {
                                    int newValue = currentValue + 1;
                                    _controller.text = newValue.toString();
                                    setState(() {
                                      currentValue = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(
                            width: 70,
                            child: FloatingActionButton(
                              elevation: 0,
                              mini: true,
                              onPressed: () {
                                int updatedReps =
                                    int.tryParse(_controller.text) ??
                                        widget.excersise.defaultreps;
                                widget.onUpdateExercise(
                                  ExerciseCard(
                                    name: widget.excersise.name,
                                    defaultreps: widget.excersise.defaultreps,
                                    repsWanted: updatedReps,
                                    isSelected: true,
                                    ismin: widget.excersise.ismin,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Text("ADD", style: _textStyle(1)),
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(int page) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: 15,
      color: _page == page ? Colors.black : Colors.grey[700],
      fontWeight: FontWeight.w500,
    );
  }
}
