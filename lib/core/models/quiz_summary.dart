import 'package:product_dice/core/models/player.dart';

class QuizSummary {
  final Player player;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;

  QuizSummary({
    required this.player,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });

  // Calculate the accuracy percentage
  double get accuracy {
    if (totalQuestions == 0) {
      return 0.0;
    }
    return (correctAnswers / totalQuestions) * 100;
  }
}
