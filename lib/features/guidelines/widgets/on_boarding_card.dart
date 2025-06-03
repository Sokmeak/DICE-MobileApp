import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:product_dice/core/data/onboarding.dart';
import 'package:product_dice/core/theme/colors.dart';

class OnBoardingCard extends StatelessWidget {
  final Onboarding onBoarding;
  final int index;

  const OnBoardingCard(
      {super.key, required this.onBoarding, required this.index});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(onBoarding.image), fit: BoxFit.fill)),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: onBoarding.title1,
                  style: const TextStyle(
                      fontSize: 34,
                      fontFamily: 'poppins-normal',
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                  children: [
                    TextSpan(
                      text: onBoarding.title2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 36),
                    )
                  ]),
            ),
            const SizedBox(height: 20),
            Text(
              onBoarding.description,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'poppins-normal',
                  color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
