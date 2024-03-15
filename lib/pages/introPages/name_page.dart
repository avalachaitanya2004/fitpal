import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key, required this.name, required this.entered_name});
  final TextEditingController name;
  final bool entered_name;

  @override
  State<NamePage> createState() =>
      _NamePageState(name: name, entered_name: entered_name);
}

class _NamePageState extends State<NamePage> {
  // final _name = TextEditingController();
  _NamePageState({required this.name, required this.entered_name});
  // TextEditingController name2 =${widget.name};
  TextEditingController name;
  bool entered_name;
  DateTime age = DateTime(2024, 3, 15);
  // print('bool is ${entered_name}');
  @override
  Widget build(BuildContext context) {
    entered_name = widget.entered_name;
    print('bool is ${entered_name}');
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const Text(
              'Whats Your Name?',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                // autofocus: true,
                // focusNode: emailnode,
                controller: name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 28,
                  ),
                  fillColor: Colors.grey[50],
                  filled: true,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    // borderSide: BorderSide(color: Colors.lightBlue, width: 4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  labelText: 'Your Name',
                  // labelStyle: const TextStyle(
                  //   color: Colors.red,
                  // ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  errorText: !entered_name ? 'Please enter your name' : null,
                  // : TextStyle(
                  //     color: Colors.blue,
                  //   )
                  // : TextStyle(
                  //     color: Colors.black,
                  //   )
                  // hintText: 'Please enter your email',
                  // hintText: 'Username',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'How old are you?',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: CupertinoDatePicker(
                          backgroundColor: Colors.white,
                          initialDateTime: age,
                          onDateTimeChanged: (DateTime newdate) {
                            setState(() {
                              age = newdate;
                            });
                          },
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                    height: 55,
                    // width: 327,

                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Text('${age}'))),
              ),
            )
          ],
        ));
  }
}
