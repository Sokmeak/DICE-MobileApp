import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/models/player.dart';
import 'package:product_dice/core/models/quiz_item.dart';
import 'package:product_dice/core/models/quiz_summary.dart';
import 'package:product_dice/core/theme/colors.dart';

class AnswerFeedbackScreen extends StatefulWidget {
  final Player player;
  final MyDiceData quizData;
  final int questionIndex;
  final bool isCorrect;

  const AnswerFeedbackScreen({
    Key? key,
    required this.player,
    required this.quizData,
    required this.questionIndex,
    required this.isCorrect,
  }) : super(key: key);

  @override
  State<AnswerFeedbackScreen> createState() => _AnswerFeedbackScreenState();
}

class _AnswerFeedbackScreenState extends State<AnswerFeedbackScreen> {
  // We need to keep track of correct answers to create the summary
  static int _correctAnswerCount = 0;

  @override
  void initState() {
    super.initState();
    // Reset count on the first question
    if (widget.questionIndex == 0) {
      _correctAnswerCount = 0;
    }
    if (widget.isCorrect) {
      _correctAnswerCount++;
    }

    Future.delayed(const Duration(seconds: 3), () {
      _navigateToNext();
    });
  }

  void _navigateToNext() {
    if (!mounted) return;

    final nextQuestionIndex = widget.questionIndex + 1;
    final totalPlayableQuestions = widget.quizData.questions!
        .where((q) => q.type != 'Slide')
        .length;

    if (nextQuestionIndex < widget.quizData.questions!.length) {
      Navigator.pushReplacementNamed(
        context,
        '/quiz_loading',
        arguments: {
          'player': widget.player,
          'quizData': widget.quizData,
          'questionIndex': nextQuestionIndex,
        },
      );
    } else {
      // **NAVIGATION CHANGE**: Quiz is over, navigate to summary screen
      final summary = QuizSummary(
        player: widget.player,
        totalQuestions: totalPlayableQuestions,
        correctAnswers: _correctAnswerCount,
        incorrectAnswers: totalPlayableQuestions - _correctAnswerCount,
      );

      Navigator.pushReplacementNamed(
        context,
        '/quiz_summary',
        arguments: summary,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int points = widget.isCorrect ? 1000 : 0;
    final Color feedbackColor =
        widget.isCorrect ? Colors.green.shade400 : Colors.red.shade400;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isCorrect ? "That's correct!" : "That's incorrect!",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: feedbackColor, width: 8),
                ),
                child: Icon(
                  widget.isCorrect ? Icons.check : Icons.close,
                  color: feedbackColor,
                  size: 80,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                widget.isCorrect
                    ? 'Answer Streak ${widget.player.answerStreak}'
                    : 'Answer Streak lost',
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.isCorrect ? '+ $points' : 'Oops!',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.isCorrect ? "You're slaying!" : "Don't be sad, try harder",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
