import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism({super.key, required this.blur, required this.child});
  final double blur;
  // final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // margin:const EdgeInsets.all(10),
      // height: 80,
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 80,
          decoration: BoxDecoration(
            // elevation:10,
            color: Colors.white.withOpacity((0.3)),
            // color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.3), // Shadow color
            //     spreadRadius: 2, // Spread radius
            //     blurRadius: 7, // Blur radius
            //     offset: Offset(0, 3), // Offset
            //   ),
            // ],
            // border:Border.all(width: 1.5, color: Colors.white.withOpacity(0.3))
          ),
          child: child,
        ),
      ),
    );
  }
}
