import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/models/player.dart';
import 'package:product_dice/core/theme/colors.dart';

class QuizLoadingScreen extends StatefulWidget {
  final Player player;
  final MyDiceData quizData;
  final int questionIndex;

  const QuizLoadingScreen({
    Key? key,
    required this.player,
    required this.quizData,
    this.questionIndex = 0,
  }) : super(key: key);

  @override
  State<QuizLoadingScreen> createState() => _QuizLoadingScreenState();
}

class _QuizLoadingScreenState extends State<QuizLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  void _loadQuestion() {
    // Simulate loading, then navigate to the question
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/play_quiz',
          arguments: {
            'player': widget.player,
            'quizData': widget.quizData,
            'questionIndex': widget.questionIndex,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.quiz, color: AppColors.skyBlue),
                    SizedBox(width: 8),
                    Text('Quiz',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                )),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Loading\nQuestion ${widget.questionIndex + 1} of ${widget.quizData.questions!.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
