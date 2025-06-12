import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';

class NextStartScreen extends StatelessWidget {
  const NextStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image covers entire screen
            Positioned.fill(
              child: Image.asset(
                AppStartImages.getStartImage2,
              ),
            ),

            // Logo positioned with top padding like GetStartScreen
            Positioned(
              top: screenHeight * 0.15,
              left: 0,
              right: 0,
              child: Center(
                child: Hero(
                  tag: 'logo-hero',
                  child: Image.asset(
                    AppStartImages.logo,
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
            ),
            // The texts positioned below the logo
            Positioned(
              top: screenHeight * 0.15 + 150 + 20,
              left: 0,
              right: 0,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.white,
                      fontFamily: 'poppins-black',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To DICE Application,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'poppins-normal',
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Learn, Grow Up, and Fun.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'poppins-normal',
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Button positioned at the bottom
            Positioned(
              bottom: screenHeight * 0.1,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: screenHeight * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonCustom(
                      text: 'Get Started',
                      color: AppColors.white,
                      textColor: AppColors.purple,
                      width: double.infinity,
                      height: 40,
                      borderRadius: 10,
                      rightIcon: Icons.arrow_forward_ios_rounded,
                      fontSize: 14,
                      borderColor: AppColors.purple,
                      borderWidth: 1,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/guidelines');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
