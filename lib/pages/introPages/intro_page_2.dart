import 'package:fit_pal/pages/introPages/goals_page.dart';
import 'package:fit_pal/pages/introPages/intro_page_1.dart';
import 'package:fit_pal/pages/introPages/metrics_page.dart';
import 'package:fit_pal/pages/introPages/name_page.dart';
import 'package:fit_pal/pages/introPages/weightmetrics.dart';
import 'package:fit_pal/pages/introPages/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _con = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    ani = Tween(begin: 0.0, end: 1.0).animate(_con!);
    super.initState();
  }

  bool check_name() {
    print('name');
    print(name.text);
    if (name.text == "") {
      print('entered');
      setState(() {
        entered_name = false;
      });
      return false;
    } else {
      setState(() {
        entered_name = true;
      });
      return true;
    }
  }

  bool entered_name = true;
  final TextEditingController name = TextEditingController();
  AnimationController? _con;
  late Animation<double> ani;
  PageController _pages = PageController();
  bool onlastPage = false;

  final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
      minimumSize: Size(327, 50),
      backgroundColor: Colors.black,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))));
  @override
  Widget build(BuildContext context) {
    print('sending bool');
    print(entered_name);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                if (index == 4) {
                  onlastPage = true;
                  _con?.forward();
                } else {
                  onlastPage = false;
                }
              });
            },
            controller: _pages,
            children: [
              // const DescriptionPage(),

              NamePage(
                name: name,
                entered_name: entered_name,
              ),
              const MetricsPage(),
              const WeightMetrics(),
              const ActivityPage(),
              const GoalsPage(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.85),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: !onlastPage
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                            // effect: WormEffect(),
                            controller: _pages,
                            count: 5,
                            // effect: SlideEffect(),
                            effect: ScrollingDotsEffect(
                              activeDotColor: Colors.black,
                              activeStrokeWidth: 2.6,
                              activeDotScale: 1.3,
                              maxVisibleDots: 5,
                              radius: 8,
                              spacing: 10,
                              dotHeight: 12,
                              dotWidth: 12,
                            )),
                        ElevatedButton(
                          onPressed: () {
                            print(name.text);
                            if (check_name()) {
                              setState(() {
                                _pages.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              });
                            }
                          },
                          child: Icon(
                            Iconsax.arrow_right_1,
                            color: Colors.white,
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.black,
                          ),
                        )
                      ],
                    )
                  : FadeTransition(
                      opacity: ani,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: buttonPrimary,
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  color: Colors.white),
                            )),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
