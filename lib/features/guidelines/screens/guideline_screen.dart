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
  PageController pageController = PageController();
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
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
            CustomIndicator(position: currentIndex),
            const SizedBox(height: 83),
            CustomOutlinedButton(
              width: 130,
              height: 50,
              borderRadius: 10,
              onTap: () {
                if (currentIndex == (onboardingList.length - 1)) {
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              text: currentIndex == (onboardingList.length - 1)
                  ? 'Get Started Now'
                  : 'Next',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
