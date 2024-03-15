// import 'package:fit_pal/pages/introPages/goals_page.dart';
// import 'package:fit_pal/pages/introPages/intro_page_1.dart';
// import 'package:fit_pal/pages/introPages/metrics_page.dart';
// import 'package:fit_pal/pages/introPages/name_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class IntroPage extends StatefulWidget {
//   const IntroPage({super.key});

//   @override
//   State<IntroPage> createState() => _IntroPageState();
// }

// class _IntroPageState extends State<IntroPage> {
//   PageController _pages = PageController();
//   bool onlastPage = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         PageView(
//           controller: _pages,
//           onPageChanged: (index) {
//             setState(() {
//               if (index == 3) {
//                 onlastPage = true;
//               } else {
//                 onlastPage = false;
//               }
//             });
//           },
//           children: [
//             const DescriptionPage(),
//             const NamePage(),
//             const MetricsPage(),
//             const GoalsPage(),
//           ],
//         ),
//         Container(
//             alignment: Alignment(0, 0.85),
//             child: !onlastPage
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             _pages.previousPage(
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.easeIn);
//                           },
//                           child: Icon(Iconsax.arrow_left)),
//                       if (!onlastPage)
//                         SmoothPageIndicator(
//                             // effect: WormEffect(),
//                             controller: _pages,
//                             count: 4,
//                             // effect: SlideEffect(),
//                             effect: ScrollingDotsEffect(
//                               activeStrokeWidth: 2.6,
//                               activeDotScale: 1.3,
//                               maxVisibleDots: 5,
//                               radius: 8,
//                               spacing: 10,
//                               dotHeight: 12,
//                               dotWidth: 12,
//                             )),
//                       GestureDetector(
//                           onTap: () {
//                             _pages.nextPage(
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.easeIn);
//                           },
//                           child: !onlastPage
//                               ? Icon(Iconsax.arrow_right_1)
//                               : Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(40),
//                                     color: Colors.blue,
//                                   ),
//                                   height: 50,
//                                   width: 100,
//                                   child: Center(child: Text('Lets Begin')),
//                                 )),
//                     ],
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               _pages.previousPage(
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.easeIn);
//                             },
//                             child: Icon(Iconsax.edit)),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         Container(
//                           height: 60,
//                           width: 250,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: Colors.blue,
//                           ),
//                           child: Center(child: Text('lets Begin')),
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                   ))
//       ],
//     ));
//   }
// }
