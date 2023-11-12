/*
  Flutter Developer Notes:

  This Dart class represents an onboarding screen that guides users through key features of 
  the BudgEx application using a series of introductory pages. It includes animations, titles, 
  and subtitles to provide an engaging and informative user experience.

  Key Components:
  - A PageView displaying multiple IntroPage widgets, each representing a distinct feature.
  - PageController to track the current page and handle page changes.
  - A dot indicator for visualizing the current onboarding page.
  - Navigation options such as 'Skip,' 'Next,' and 'Done' for user interaction.

  Note: Ensure that the animations and content of each IntroPage are correctly specified. 
  Verify that the navigation to the Login page is functioning as expected after completing 
  the onboarding.

  Exceptional work on creating an onboarding experience that effectively introduces users to 
  the core features of BudgEx!
*/

import 'package:budgex/pages/other_screens/intro_page.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Controller to keep track of which page we're on
  final PageController _controller = PageController();

  // Keep Track of if we are on the last page or not
  bool onLastPage = false;

  // Function to navigate the user to the Login page.
  void toLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UserLogin(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: [
              IntroPage(
                  fileName: 'assets/animations/page_1_animation.json',
                  title: "Sleek and Smart Finance",
                  subTitle:
                      "Welcome to BudgEx – the sleek solution for effortless expense tracking. Scan receipts, set budgets, and gain financial insights with ease."),
              IntroPage(
                  fileName: 'assets/animations/page_2_animation.json',
                  title: "Receipts, Redefined",
                  subTitle:
                      "Revolutionize the way you track expenses! BudgEx introduces a seamless receipt scanning experience, making financial management simple and stress-free."),
              IntroPage(
                  fileName: 'assets/animations/page_3_animation.json',
                  title: "Your Money, Your Rules",
                  subTitle:
                      "Take charge of your finances with BudgEx. From intuitive expense tracking to powerful receipt scanning, our app adapts to your financial style for a personalized money management experience."),
            ],
          ),

          // Dot Indicator
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(fontFamily: poppins['semiBold']),
                    )),

                // Dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // next or done
                onLastPage
                    ? GestureDetector(
                        onTap: toLoginPage,
                        child: Text(
                          'Done',
                          style: TextStyle(fontFamily: poppins['semiBold']),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(fontFamily: poppins['semiBold']),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
