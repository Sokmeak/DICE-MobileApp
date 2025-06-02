import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_battle/models/quiz.dart';
import 'package:quiz_battle/screens/quiz_results_screen.dart';
import 'package:quiz_battle/theme/app_theme.dart';

class PlayQuizScreen extends StatefulWidget {
  const PlayQuizScreen({Key? key}) : super(key: key);

  @override
  State<PlayQuizScreen> createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 30;
  Timer? _timer;
  int? _selectedAnswerIndex;
  bool _isAnswerRevealed = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Mock quiz data
  final Quiz _quiz = Quiz(
    id: '1',
    title: 'General Knowledge',
    description: 'Test your knowledge on various topics',
    creatorId: 'user1',
    creatorName: 'Alex Johnson',
    questions: [
      Question(
        id: '1',
        text: 'What is the capital of France?',
        answers: [
          Answer(id: '1', text: 'Paris', isCorrect: true),
          Answer(id: '2', text: 'London', isCorrect: false),
          Answer(id: '3', text: 'Berlin', isCorrect: false),
          Answer(id: '4', text: 'Madrid', isCorrect: false),
        ],
        timeLimit: 30,
      ),
      Question(
        id: '2',
        text: 'Which planet is known as the Red Planet?',
        answers: [
          Answer(id: '1', text: 'Venus', isCorrect: false),
          Answer(id: '2', text: 'Mars', isCorrect: true),
          Answer(id: '3', text: 'Jupiter', isCorrect: false),
          Answer(id: '4', text: 'Saturn', isCorrect: false),
        ],
        timeLimit: 30,
      ),
      Question(
        id: '3',
        text: 'Who painted the Mona Lisa?',
        answers: [
          Answer(id: '1', text: 'Vincent van Gogh', isCorrect: false),
          Answer(id: '2', text: 'Pablo Picasso', isCorrect: false),
          Answer(id: '3', text: 'Leonardo da Vinci', isCorrect: true),
          Answer(id: '4', text: 'Michelangelo', isCorrect: false),
        ],
        timeLimit: 30,
      ),
    ],
    createdAt: DateTime.now(),
    plays: 245,
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    final question = _quiz.questions[_currentQuestionIndex];
    _timeLeft = question.timeLimit;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _revealAnswer();
        }
      });
    });
  }

  void _selectAnswer(int index) {
    if (_isAnswerRevealed) return;
    
    setState(() {
      _selectedAnswerIndex = index;
    });
    
    _revealAnswer();
  }

  void _revealAnswer() {
    _timer?.cancel();
    
    setState(() {
      _isAnswerRevealed = true;
    });
    
    final question = _quiz.questions[_currentQuestionIndex];
    final correctAnswerIndex = question.answers.indexWhere((answer) => answer.isCorrect);
    
    if (_selectedAnswerIndex != null && _selectedAnswerIndex == correctAnswerIndex) {
      // Calculate score based on time left
      final timeBonus = (_timeLeft / question.timeLimit) * 100;
      _score += 100 + timeBonus.round();
    }
    
    // Wait before moving to next question
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quiz.questions.length - 1) {
      _animationController.forward().then((_) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswerIndex = null;
          _isAnswerRevealed = false;
        });
        
        _animationController.reset();
        _startTimer();
      });
    } else {
      // Quiz completed
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultsScreen(
            score: _score,
            totalQuestions: _quiz.questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _quiz.questions[_currentQuestionIndex];
    final correctAnswerIndex = question.answers.indexWhere((answer) => answer.isCorrect);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress and timer
              Row(
                children: [
                  // Question progress
                  Text(
                    'Question ${_currentQuestionIndex + 1}/${_quiz.questions.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // Timer
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _timeLeft > 10
                          ? Colors.green
                          : _timeLeft > 5
                              ? Colors.orange
                              : Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$_timeLeft s',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Progress bar
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _quiz.questions.length,
                backgroundColor: Colors.grey.shade200,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 24),
              
              // Question
              Text(
                question.text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Answers
              Expanded(
                child: ListView.builder(
                  itemCount: question.answers.length,
                  itemBuilder: (context, index) {
                    final answer = question.answers[index];
                    
                    // Determine button color based on state
                    Color buttonColor = Colors.white;
                    Color textColor = Colors.black;
                    
                    if (_isAnswerRevealed) {
                      if (index == correctAnswerIndex) {
                        buttonColor = Colors.green;
                        textColor = Colors.white;
                      } else if (index == _selectedAnswerIndex) {
                        buttonColor = Colors.red;
                        textColor = Colors.white;
                      }
                    } else if (index == _selectedAnswerIndex) {
                      buttonColor = AppTheme.primaryColor;
                      textColor = Colors.white;
                    }
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        onPressed: _isAnswerRevealed ? null : () => _selectAnswer(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: textColor,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: textColor == Colors.white
                                    ? Colors.white.withOpacity(0.3)
                                    : AppTheme.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index), // A, B, C, D
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor == Colors.white
                                        ? Colors.white
                                        : AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                answer.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Score
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Score: $_score',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

