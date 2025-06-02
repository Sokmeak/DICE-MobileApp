import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/features/auth/screens/next_start_screen.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 700),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const NextStartScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final zoomAnimation =
                      Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  );

                  final fadeAnimation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  );

                  return FadeTransition(
                    opacity: fadeAnimation,
                    child: ScaleTransition(
                      scale: zoomAnimation,
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Stack(
            children: [
              // Background image, height adjusted responsively
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppStartImages.getStartImage1,
                  height: screenHeight * 0.5,
                  width: double.infinity,
                ),
              ),

              // Logo with Hero and ZoomIn animation
              Positioned(
                top: screenHeight * 0.15,
                left: 0,
                right: 0,
                child: ZoomIn(
                  duration: const Duration(milliseconds: 600),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
