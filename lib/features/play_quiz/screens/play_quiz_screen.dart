import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/models/player.dart';
import 'package:product_dice/core/models/quiz_item.dart';
import 'package:product_dice/core/theme/colors.dart';
import '../widgets/answer_card.dart';

class PlayQuizScreen extends StatefulWidget {
  final Player player;
  final MyDiceData quizData;
  final int questionIndex;

  const PlayQuizScreen({
    Key? key,
    required this.player,
    required this.quizData,
    required this.questionIndex,
  }) : super(key: key);

  @override
  State<PlayQuizScreen> createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen> {
  Timer? _timer;
  int _timeRemaining = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    final question = widget.quizData.questions![widget.questionIndex];
    _timeRemaining = question.timeLimit ?? 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer?.cancel();
        // Time's up, count as incorrect
        _submitAnswer(-1); // Use -1 to indicate timeout
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _submitAnswer(int selectedIndex) {
    _timer?.cancel(); // Stop the timer once an answer is submitted
    final QuizItem question = widget.quizData.questions![widget.questionIndex];
    bool isCorrect = false;

    if (selectedIndex != -1) { // Check if not a timeout
      if (question.type == 'Quiz' && question.correctOptionIndex != null) {
        isCorrect = selectedIndex == question.correctOptionIndex;
      } else if (question.type == 'True or False') {
        String selectedAnswer = selectedIndex == 0 ? 'True' : 'False';
        isCorrect = selectedAnswer == question.selectedAnswer;
      }
    }

    if (isCorrect) {
      widget.player.score += 1000 + (_timeRemaining * 10); // Bonus for speed
      widget.player.answerStreak++;
    } else {
      widget.player.answerStreak = 0;
    }

    Navigator.pushReplacementNamed(
      context,
      '/answer_feedback',
      arguments: {
        'player': widget.player,
        'quizData': widget.quizData,
        'questionIndex': widget.questionIndex,
        'isCorrect': isCorrect,
      },
    );
  }

  void _handleSlide() {
    _timer?.cancel();
    Future.delayed(Duration(seconds: _timeRemaining), () {
      if (mounted) {
        _navigateToNextQuestion();
      }
    });
  }

  void _navigateToNextQuestion() {
    final nextQuestionIndex = widget.questionIndex + 1;
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
      Navigator.pushReplacementNamed(context, '/quiz_results', arguments: widget.player);
    }
  }

  @override
  Widget build(BuildContext context) {
    final QuizItem currentQuestion = widget.quizData.questions![widget.questionIndex];
     if (currentQuestion.type == 'Slide') {
      _handleSlide();
    }

    return Scaffold(
      backgroundColor: AppColors.primary.withOpacity(0.9),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              flex: 3,
              child: _buildQuestionBody(context, currentQuestion),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2)
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Text(
                '$_timeRemaining',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.questionIndex + 1} of ${widget.quizData.questions!.length}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuestionBody(BuildContext context, QuizItem question) {
    switch (question.type) {
      case 'Quiz':
        return _buildMultipleChoice(context, question);
      case 'True or False':
        return _buildTrueFalse(context, question);
      case 'Slide':
        return _buildSlide(context, question);
      default:
        return const Center(child: Text('Unsupported Question Type', style: TextStyle(color: Colors.white)));
    }
  }

  Widget _buildMultipleChoice(BuildContext context, QuizItem question) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(question.question!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AnswerCard(color: Colors.red.shade400, icon: Icons.favorite, text: question.options![0], onTap: () => _submitAnswer(0)),
              AnswerCard(color: Colors.blue.shade400, icon: Icons.star, text: question.options![1], onTap: () => _submitAnswer(1)),
              AnswerCard(color: Colors.orange.shade400, icon: Icons.bolt, text: question.options![2], onTap: () => _submitAnswer(2)),
              AnswerCard(color: Colors.green.shade400, icon: Icons.grass, text: question.options![3], onTap: () => _submitAnswer(3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrueFalse(BuildContext context, QuizItem question) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(question.question!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Row(
            children: [
              Expanded(child: AnswerCard(color: Colors.blue.shade400, icon: Icons.thumb_up, text: "True", onTap: () => _submitAnswer(0))),
              Expanded(child: AnswerCard(color: Colors.red.shade400, icon: Icons.thumb_down, text: "False", onTap: () => _submitAnswer(1))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlide(BuildContext context, QuizItem question) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(question.title!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(question.description!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 18)),
            const Spacer(),
             const Text("Moving to the next question...", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.black.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(widget.player.avatarUrl)),
              const SizedBox(width: 12),
              Text(widget.player.nickname, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          Text('${widget.player.score} pt', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}

