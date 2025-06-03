import 'package:flutter/material.dart';

class Onboarding {
  String title1;
  String? title2;
  String description;
  IconData icons;

  Onboarding({
    required this.title1,
    this.title2,
    required this.description,
    required this.icons,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
    title1: 'Create Engaging ',
    title2: 'Quizzes',
    description:
        'Design beautiful quizzes with multiple-choice questions, images, and time limits.',
    icons: Icons.create_rounded,
  ),
  Onboarding(
      title1: 'Host Live ',
      title2: 'Games',
      description:
          'Invite players to join with a game code and compete in real-time.',
      icons: Icons.people_alt_rounded),
  Onboarding(
      title1: 'Track ',
      title2: 'Performance',
      description:
          'View detailed analytics and insights about quiz performance.',
      icons: Icons.bar_chart_rounded),
];
