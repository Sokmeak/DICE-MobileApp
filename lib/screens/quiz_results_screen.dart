import 'package:flutter/material.dart';
import 'package:quiz_battle/screens/home_screen.dart';
import 'package:quiz_battle/theme/app_theme.dart';
import 'package:quiz_battle/widgets/gradient_button.dart';

class QuizResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate percentage
    final percentage = (score / (totalQuestions * 100)) * 100;
    
    // Determine result message
    String resultMessage;
    Color resultColor;
    IconData resultIcon;
    
    if (percentage >= 80) {
      resultMessage = 'Excellent!';
      resultColor = Colors.green;
      resultIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      resultMessage = 'Good job!';
      resultColor = Colors.blue;
      resultIcon = Icons.thumb_up;
    } else if (percentage >= 40) {
      resultMessage = 'Not bad!';
      resultColor = Colors.orange;
      resultIcon = Icons.sentiment_satisfied;
    } else {
      resultMessage = 'Keep practicing!';
      resultColor = Colors.red;
      resultIcon = Icons.sentiment_dissatisfied;
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Result icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: resultColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    resultIcon,
                    size: 60,
                    color: resultColor,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Result message
                Text(
                  resultMessage,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Quiz Completed',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Score
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          const Text(
                            'Your Score',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$score pts',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Leaderboard
                const Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLeaderboardItem(1, 'You', score, true),
                _buildLeaderboardItem(2, 'Alex', score - 50, false),
                _buildLeaderboardItem(3, 'Taylor', score - 120, false),
                _buildLeaderboardItem(4, 'Jordan', score - 200, false),
                const SizedBox(height: 32),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Play again
                        },
                        child: const Text('Play Again'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GradientButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                            (route) => false,
                          );
                        },
                        text: 'Home',
                        gradient: AppTheme.primaryGradient,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(int position, String name, int score, bool isCurrentUser) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppTheme.primaryColor.withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser
            ? Border.all(color: AppTheme.primaryColor)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: position == 1
                  ? Colors.amber
                  : position == 2
                      ? Colors.grey.shade400
                      : position == 3
                          ? Colors.brown.shade300
                          : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$position',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            name,
            style: TextStyle(
              fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            '$score pts',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

