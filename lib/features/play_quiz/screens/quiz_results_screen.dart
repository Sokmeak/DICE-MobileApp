import 'package:flutter/material.dart';
import 'package:product_dice/core/models/player.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';

class QuizResultsScreen extends StatelessWidget {
  final Player player;
  const QuizResultsScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is a simplified version. A real leaderboard would involve fetching other player scores.
    // For now, we assume this player is #1.
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: -60,
                    child: Icon(Icons.emoji_events, color: Colors.yellow, size: 100),
                  ),
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(player.avatarUrl),
                    backgroundColor: Colors.white,
                  ),
                   Positioned(
                    bottom: -20,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Text(
                player.nickname,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Congratulation!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 60),
              ButtonCustom(
                text: 'View Leader Board',
                onPressed: () {
                  // For now, just pop back to the first screen (usually home/landing)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                color: Colors.white,
                textColor: AppColors.primary,
                fontSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
