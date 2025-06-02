import 'package:flutter/material.dart';
import 'package:quiz_battle/models/quiz.dart';
import 'package:quiz_battle/screens/play_quiz_screen.dart';
import 'package:quiz_battle/theme/app_theme.dart';
import 'package:quiz_battle/widgets/gradient_button.dart';

class QuizDetailsScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailsScreen({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                quiz.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  image: quiz.coverImage != null
                      ? DecorationImage(
                          image: AssetImage(quiz.coverImage!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        )
                      : null,
                ),
                child: quiz.coverImage == null
                    ? Center(
                        child: Icon(
                          Icons.quiz,
                          size: 80,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      )
                    : null,
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quiz info
                  Text(
                    quiz.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Creator info
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: Text(
                          quiz.creatorName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Created by',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            quiz.creatorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats
                  Row(
                    children: [
                      _buildStatItem(Icons.play_arrow, '${quiz.plays} plays'),
                      const SizedBox(width: 16),
                      _buildStatItem(
                        Icons.calendar_today,
                        'Created ${_formatDate(quiz.createdAt)}',
                      ),
                      const SizedBox(width: 16),
                      _buildStatItem(
                        Icons.help_outline,
                        '${quiz.questions.length} questions',
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Play button
                  GradientButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PlayQuizScreen()),
                      );
                    },
                    text: 'Play Quiz',
                    gradient: AppTheme.primaryGradient,
                    icon: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(height: 16),
                  
                  // Share button
                  OutlinedButton.icon(
                    onPressed: () {
                      // Share quiz
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share Quiz'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Questions preview
                  const Text(
                    'Questions Preview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Questions list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quiz.questions.length,
                    itemBuilder: (context, index) {
                      final question = quiz.questions[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question ${index + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                question.text,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${question.answers.length} answers • ${question.timeLimit} seconds',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

