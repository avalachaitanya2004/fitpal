// import 'dart:ui';

// import 'package:fit_pal/models/food.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class FoodDisplay extends StatelessWidget {
//   const FoodDisplay({super.key, required this.food});
//   final Food food;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Material(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           // margin: EdgeInsets.all(5),
//           height: 160,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/calorie_preview.webp'),
//               fit: BoxFit.cover,
//             ),
//             // color: Colors.lightGreen,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       // color: Colors.blue,
//                       child: Column(
//                         children: [
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 '${food.name}',
//                                 style: TextStyle(fontSize: 30),
//                               )),
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: Text('${food.calorie} kcal')),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       flex: 1,
//                       child: Container(
//                         // color: Colors.yellow,
//                         child: Align(
//                             alignment: Alignment.bottomRight,
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(20)),
//                                 // color: Colors.white,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(7.0),
//                                   child: Text('${food.title}'),
//                                 ))),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:fit_pal/models/food.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoodDisplay extends StatelessWidget {
  const FoodDisplay({Key? key, required this.food}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 160,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/calorie_preview.webp'),
              fit: BoxFit.cover,
            ),
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${food.name}',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(height: 10),
                          Text('${food.calorie} kcal'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text('${food.title}'),
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
}
// import 'dart:ui';

// import 'package:fit_pal/models/food.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class FoodDisplay extends StatelessWidget {
//   const FoodDisplay({Key? key, required this.food}) : super(key: key);
//   final Food food;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Material(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           height: 160,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             color: Colors.lightGreen,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.5), // Adjust the opacity here
//                       BlendMode.dstATop,
//                     ),
//                     child: Image.asset(
//                       'assets/images/calorie_preview.webp',
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             '${food.name}',
//                             style: TextStyle(fontSize: 30),
//                           ),
//                           SizedBox(height: 10),
//                           Text('${food.calorie} kcal'),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(7.0),
//                             child: Text('${food.title}'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
