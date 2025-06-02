import 'package:flutter/material.dart';
import 'package:quiz_battle/screens/play_quiz_screen.dart';
import 'package:quiz_battle/theme/app_theme.dart';
import 'package:quiz_battle/widgets/gradient_button.dart';

class QuizLobbyScreen extends StatefulWidget {
  final String quizCode;
  final String playerName;

  const QuizLobbyScreen({
    Key? key,
    required this.quizCode,
    required this.playerName,
  }) : super(key: key);

  @override
  State<QuizLobbyScreen> createState() => _QuizLobbyScreenState();
}

class _QuizLobbyScreenState extends State<QuizLobbyScreen> {
  final List<String> _players = [];
  bool _isHost = false;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    // Simulate API call to get players
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _players.addAll([
        widget.playerName,
        'Alex',
        'Taylor',
        'Jordan',
      ]);
      
      // For demo purposes, make the current user the host
      _isHost = true;
    });
  }

  void _startQuiz() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const PlayQuizScreen(),
      ),
    );
  }

  void _toggleReady() {
    setState(() {
      _isReady = !_isReady;
    });
  }

  void _leaveQuiz() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Lobby'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _leaveQuiz,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Quiz code
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Quiz Code: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.quizCode,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        // Copy to clipboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Quiz code copied to clipboard'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Players list
              const Text(
                'Players',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _players.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _players.length,
                        itemBuilder: (context, index) {
                          final player = _players[index];
                          final isCurrentPlayer = player == widget.playerName;
                          
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isCurrentPlayer
                                  ? AppTheme.primaryColor
                                  : Colors.grey.shade200,
                              child: Text(
                                player[0].toUpperCase(),
                                style: TextStyle(
                                  color: isCurrentPlayer
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            title: Text(
                              player,
                              style: TextStyle(
                                fontWeight: isCurrentPlayer
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: index == 0
                                ? const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  )
                                : const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 24),
              
              // Action buttons
              if (_isHost)
                GradientButton(
                  onPressed: _startQuiz,
                  text: 'Start Quiz',
                  gradient: AppTheme.primaryGradient,
                )
              else
                GradientButton(
                  onPressed: _toggleReady,
                  text: _isReady ? 'Not Ready' : 'Ready',
                  gradient: _isReady
                      ? LinearGradient(
                          colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade500,
                          ],
                        )
                      : AppTheme.primaryGradient,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

