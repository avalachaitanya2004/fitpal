import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'numberpicker.dart';
import 'numberpicker2.dart';
import 'numberpicker3.dart';

class DecimalNumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final double value;
  final ValueChanged<double> onChanged;
  final int itemCount;
  final double itemHeight;
  final double itemWidth;
  final Axis axis;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final bool haptics;
  final TextMapper? integerTextMapper;
  final TextMapper? decimalTextMapper;
  final bool integerZeroPad;

  /// Decoration to apply to central box where the selected integer value is placed
  final Decoration? integerDecoration;

  /// Decoration to apply to central box where the selected decimal value is placed
  final Decoration? decimalDecoration;

  /// Inidcates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  const DecimalNumberPicker({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
    this.itemCount = 5,
    this.itemHeight = 50,
    this.itemWidth = 100,
    this.axis = Axis.vertical,
    this.textStyle,
    this.selectedTextStyle,
    this.haptics = false,
    this.decimalPlaces = 1,
    this.integerTextMapper,
    this.decimalTextMapper,
    this.integerZeroPad = false,
    this.integerDecoration,
    this.decimalDecoration,
  })  : assert(minValue <= value),
        assert(value <= maxValue),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final decimalValue =
        ((value - value.floorToDouble()) * math.pow(10, decimalPlaces)).round();
    final doubleMaxValue = 11;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //height in ft/in 3 to 8' 11''
        //in cm 91 to 271 cm
        //weight 30 to 300.9 kg
        //weight 66 to 66.9 lb
        //age 13 to 99
        //
        NumberPicker2(
          minValue: 3,
          maxValue: 8,
          value: value.floor(),
          onChanged: _onIntChanged,
          itemCount: itemCount,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          textStyle: textStyle,
          selectedTextStyle: selectedTextStyle,
          haptics: haptics,
          zeroPad: integerZeroPad,
          textMapper2: integerTextMapper,
          decoration: integerDecoration,
        ),
        NumberPicker3(
          minValue: 0,
          maxValue: doubleMaxValue,
          value: decimalValue,
          onChanged: _onDoubleChanged,
          itemCount: itemCount,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          textStyle: textStyle,
          selectedTextStyle: selectedTextStyle,
          haptics: haptics,
          textMapper3: decimalTextMapper,
          decoration: decimalDecoration,
        ),
      ],
    );
  }

  void _onIntChanged(int intValue) {
    final newValue =
        (value - value.floor() + intValue).clamp(minValue, maxValue);
    onChanged(newValue.toDouble());
  }

  void _onDoubleChanged(int doubleValue) {
    final decimalPart = double.parse(
        (doubleValue * math.pow(10, -decimalPlaces))
            .toStringAsFixed(decimalPlaces));
    onChanged(value.floor() + decimalPart);
  }
}
