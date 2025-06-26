import 'package:flutter/material.dart';
import 'package:product_dice/core/models/quiz_summary.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';

class QuizSummaryScreen extends StatelessWidget {
  final QuizSummary summary;

  const QuizSummaryScreen({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Quiz Complete!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Here\'s how you did, ${summary.player.nickname}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              _buildScoreCard(),
              const SizedBox(height: 40),
              ButtonCustom(
                text: 'See Final Results',
                onPressed: () {
                  // Navigate to the final podium screen
                  Navigator.pushNamed(context, '/quiz_results',
                      arguments: summary.player);
                },
                color: AppColors.primary,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Your Score',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            '${summary.player.score} pts',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Divider(height: 40),
          _buildStatRow(
            icon: Icons.check_circle,
            label: 'Correct',
            value: '${summary.correctAnswers}',
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            icon: Icons.cancel,
            label: 'Incorrect',
            value: '${summary.incorrectAnswers}',
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            icon: Icons.star,
            label: 'Accuracy',
            value: '${summary.accuracy.toStringAsFixed(0)}%',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
      {required IconData icon,
      required String label,
      required String value,
      required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 18, color: AppColors.text),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.text),
        ),
      ],
    );
  }
}
