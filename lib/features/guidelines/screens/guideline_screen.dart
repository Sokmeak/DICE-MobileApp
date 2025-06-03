import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_dice/core/data/onboarding.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/features/guidelines/widgets/custom_indicator.dart';
import 'package:product_dice/features/guidelines/widgets/custom_outlined_button.dart';
import 'package:product_dice/features/guidelines/widgets/on_boarding_card.dart';

class GuidelineScreen extends StatefulWidget {
  const GuidelineScreen({super.key});

  @override
  State<GuidelineScreen> createState() => _GuidelineScreenState();
}

class _GuidelineScreenState extends State<GuidelineScreen> {
  final PageController pageController = PageController();
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen size once for relative sizing
    final size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.06),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: onboardingList.length,
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value.toDouble();
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingCard(
                      index: index,
                      onBoarding: onboardingList[index],
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.025),
              CustomIndicator(position: currentIndex),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomOutlinedButton(
                      width: double.infinity,
                      height: size.height *
                          0.055, // button height relative to screen
                      borderRadius: 10,
                      gradientColors: AppColors.gradientColors,
                      color: AppColors.white,
                      onTap: () {
                        if (currentIndex == (onboardingList.length - 1)) {
                          Navigator.of(context).pushNamed('/signin');
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      text: currentIndex == (onboardingList.length - 1)
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    flex: 4,
                    child: CustomOutlinedButton(
                      width: double.infinity,
                      height: size.height * 0.055,
                      borderRadius: 10,
                      onTap: () {
                        Navigator.of(context).pushNamed('/landing');
                      },
                      text: 'Skip',
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
