import 'package:flutter/material.dart';
import 'package:product_dice/features/auth/screens/get_start_screen.dart';
import 'package:product_dice/features/auth/screens/sign_in_screen.dart';
import 'package:product_dice/features/auth/screens/sign_up_screen.dart';
import 'package:product_dice/features/guidelines/screens/guideline_screen.dart';
import 'package:product_dice/features/landing/screens/landing_screen.dart';
import 'package:product_dice/features/profile/screens/profile_screen.dart';
import 'package:product_dice/features/setting/screens/privacy_setting_screen.dart';
import 'package:product_dice/features/setting/screens/profile_setting_screen.dart';
import 'package:product_dice/features/setting/screens/setting_screen.dart';

Route createFadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return createFadeRoute(const GetStartScreen());
    case '/signin':
      return createFadeRoute(const SignInScreen());
    case '/signup':
      return createFadeRoute(const SignUpScreen());
    case '/landing':
      return createFadeRoute(const LandingScreen());
    case '/guidelines':
      return createFadeRoute(const GuidelineScreen());
    case '/profile':
      return createFadeRoute(const ProfileScreen());
    case '/setting':
      return createFadeRoute(const SettingScreen());
    case '/profile-settings':
      return createFadeRoute(const ProfileSettingScreen());
    case '/privacy-settings':
      return createFadeRoute(const PrivacySettingScreen());
    default:
      return null;
  }
}
