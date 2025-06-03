import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:product_dice/core/data/onboarding.dart';
import 'package:product_dice/core/theme/colors.dart';

class OnBoardingCard extends StatelessWidget {
  final Onboarding onBoarding;
  final int index;

  const OnBoardingCard({
    super.key,
    required this.onBoarding,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double padding = screenWidth * 0.07;
    final double titleSize1 = screenWidth * 0.08;
    final double titleSize2 = screenWidth * 0.085;
    final double descSize = screenWidth * 0.045;
    final double iconSize = screenWidth * 0.15;

    // Responsive card size
    final double cardWidth = screenWidth * 0.80;
    final double cardHeight = screenHeight * 0.35;

    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive SizedBox wrapping Card
            SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                color: AppColors.purpleSecondary,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.08),
                  child: Center(
                    child: Icon(
                      onBoarding.icons,
                      size: iconSize,
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.045),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: onBoarding.title1,
                style: TextStyle(
                  fontSize: titleSize1,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                children: [
                  TextSpan(
                    text: onBoarding.title2,
                    style: TextStyle(
                      fontSize: titleSize2,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'poppins-normal',
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              onBoarding.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: descSize,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins-normal',
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
