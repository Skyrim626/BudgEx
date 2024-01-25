// Import necessary packages and files
import 'package:budgex/widgets/custom_intro_page.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:budgex/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// A class responsible for displaying Onboarding Screen
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

  // Function to navigate the user to the Login page(Part from Wrapper).
  void toLoginPage() {
    final route = MaterialPageRoute(builder: (context) => const Wrapper());

    // Use Navigator.pushAndRemoveUntil to navigate to the Wrapper page and remove all previous routes
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
                        child: CustomText(
                            title: "Done",
                            fontSize: 14,
                            fontFamily: poppins['semiBold']!),

                        /* Text(
                          'Done',
                          style: TextStyle(fontFamily: poppins['semiBold']),
                        ) */
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: CustomText(
                            title: "Next",
                            fontSize: 14,
                            fontFamily: poppins['semiBold']!),

                        /* Text(
                          'Next',
                          style: TextStyle(fontFamily: poppins['semiBold'], ),
                        ) */
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
