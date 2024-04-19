import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fit_pal/numberpicker/numberpicker.dart';

class NamePage extends StatefulWidget {
  NamePage(
      {super.key,
      required this.name,
      required this.entered_name,
      required this.isFirstTime,
      required this.age});
  final TextEditingController name;
  final TextEditingController age;
  bool entered_name;
  final bool isFirstTime;

  @override
  State<NamePage> createState() => _NamePageState(
      name: name, entered_name: entered_name, isFirstTime: isFirstTime);
}

class _NamePageState extends State<NamePage> {
  // final _name = TextEditingController();
  _NamePageState(
      {required this.name,
      required this.entered_name,
      required this.isFirstTime});
  // TextEditingController name2 =${widget.name};
  TextEditingController name;
  late TextEditingController ages;
  @override
  void initState() {
    ages = widget.age;
    super.initState();
  }

  bool entered_name;
  bool isFirstTime;
  DateTime age = DateTime(2024, 3, 15);
  int _currentValue = 18;
  // print('bool is ${entered_name}');
  @override
  Widget build(BuildContext context) {
    ages.text = _currentValue.toString();
    entered_name = widget.entered_name;
    print('bool is ${entered_name}');
    return SingleChildScrollView(
      child: Container(
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
                  autofocus: isFirstTime ? true : false,
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
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    labelText: 'Your Name',
                    // labelStyle: const TextStyle(
                    //   color: Colors.red,
                    // ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
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
              NumberPicker(
                haptics: true,
                value: _currentValue,
                minValue: 13,
                maxValue: 100,
                onChanged: (value) => setState(() => _currentValue = value),
              ),
            ],
          )),
    );
  }
}
