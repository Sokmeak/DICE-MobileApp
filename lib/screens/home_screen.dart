import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_battle/models/quiz.dart';
import 'package:quiz_battle/providers/auth_provider.dart';
import 'package:quiz_battle/screens/auth/login_screen.dart';
import 'package:quiz_battle/screens/create_quiz_screen.dart';
import 'package:quiz_battle/screens/dashboard/dashboard_screen.dart';
import 'package:quiz_battle/screens/join_quiz_screen.dart';
import 'package:quiz_battle/theme/app_theme.dart';
import 'package:quiz_battle/widgets/gradient_button.dart';
import 'package:quiz_battle/widgets/quiz_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for featured quizzes
  final List<Quiz> _featuredQuizzes = [
    Quiz(
      id: '1',
      title: 'General Knowledge',
      description: 'Test your knowledge on various topics',
      creatorId: 'user1',
      creatorName: 'Alex Johnson',
      questions: [],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      plays: 245,
      coverImage: 'assets/images/quiz_general.jpg',
    ),
    Quiz(
      id: '2',
      title: 'Science Trivia',
      description: 'Challenge yourself with science facts and discoveries',
      creatorId: 'user2',
      creatorName: 'Taylor Smith',
      questions: [],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      plays: 128,
    ),
    Quiz(
      id: '3',
      title: 'Movie Quotes',
      description: 'Guess the movie from famous quotes',
      creatorId: 'user3',
      creatorName: 'Jordan Lee',
      questions: [],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      plays: 89,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Q",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "QuizBattle",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // User avatar or login button
                  authProvider.isAuthenticated
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const DashboardScreen()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: authProvider.user!.avatar != null
                                ? NetworkImage(authProvider.user!.avatar!)
                                : null,
                            child: authProvider.user!.avatar == null
                                ? Text(
                                    authProvider.user!.name[0].toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  )
                                : null,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                          child: const Text("Log in"),
                        ),
                ],
              ),
            ),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Create, Play, Learn\nwith QuizBattle",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Engage your audience with stunning interactive quizzes",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: GradientButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const CreateQuizScreen()),
                                      );
                                    },
                                    text: "Create Quiz",
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.2),
                                        Colors.white.withOpacity(0.3),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: GradientButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const JoinQuizScreen()),
                                      );
                                    },
                                    text: "Join Game",
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 204, 66, 66),
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Features section
                      const Text(
                        "Why QuizBattle?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildFeatureCard(
                              icon: Icons.create,
                              title: "Create",
                              description: "Design beautiful quizzes with multiple-choice questions",
                              color: Colors.purple,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildFeatureCard(
                              icon: Icons.people,
                              title: "Play",
                              description: "Invite players to join with a game code",
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildFeatureCard(
                              icon: Icons.emoji_events,
                              title: "Win",
                              description: "Score points based on correct answers and speed",
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildFeatureCard(
                              icon: Icons.insights,
                              title: "Learn",
                              description: "Track progress and improve your knowledge",
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Featured quizzes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Featured Quizzes",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to explore screen
                            },
                            child: const Text("See all"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _featuredQuizzes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == _featuredQuizzes.length - 1 ? 0 : 16,
                              ),
                              child: SizedBox(
                                width: 200,
                                child: QuizCard(quiz: _featuredQuizzes[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

