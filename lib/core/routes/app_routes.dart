import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/models/player.dart';
import 'package:product_dice/core/models/quiz_summary.dart';
import 'package:product_dice/features/auth/screens/get_start_screen.dart';
import 'package:product_dice/features/auth/screens/next_start_screen.dart';
import 'package:product_dice/features/auth/screens/sign_in_screen.dart';
import 'package:product_dice/features/auth/screens/sign_up_screen.dart';
import 'package:product_dice/features/createquiz/screens/create_quiz_screen.dart';
import 'package:product_dice/features/guidelines/screens/guideline_screen.dart';
import 'package:product_dice/features/landing/screens/landing_screen.dart';
import 'package:product_dice/features/mydice/screens/all_dice_screen.dart';
import 'package:product_dice/features/profile/screens/profile_screen.dart';
import 'package:product_dice/features/setting/screens/delete_account_screen.dart';
import 'package:product_dice/features/setting/screens/faq_screen.dart';
import 'package:product_dice/features/setting/screens/language_screen.dart';
import 'package:product_dice/features/setting/screens/privacy_policy_screen.dart';
import 'package.dart';
import 'package:product_dice/features/setting/screens/profile_setting_screen.dart';
import 'package:product_dice/features/setting/screens/setting_screen.dart';
import 'package:product_dice/features/setting/screens/terms_condition_screen.dart';
import 'package:product_dice/features/setting/screens/user_type_screen.dart';
import 'package:product_dice/test_data_screen.dart';

// Import the play_quiz feature screens
import 'package:product_dice/features/play_quiz/screens/join_quiz_screen.dart';
import 'package:product_dice/features/play_quiz/screens/enter_nickname_screen.dart';
import 'package:product_dice/features/play_quiz/screens/quiz_lobby_screen.dart';
import 'package:product_dice/features/play_quiz/screens/quiz_loading_screen.dart';
import 'package:product_dice/features/play_quiz/screens/play_quiz_screen.dart';
import 'package:product_dice/features/play_quiz/screens/answer_feedback_screen.dart';
import 'package:product_dice/features/play_quiz/screens/quiz_summary_screen.dart';
import 'package:product_dice/features/play_quiz/screens/quiz_results_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Core App Flow
      case '/': // Assuming the root might be the get-start screen
      case '/get-start':
        return _fadeRoute(const GetStartScreen());
      case '/next-start':
        return _fadeRoute(const NextStartScreen());
      case '/sign-in':
        return _fadeRoute(const SignInScreen());
      case '/sign-up':
        return _fadeRoute(const SignUpScreen());
      case '/landing':
        return _fadeRoute(const LandingScreen());
      case '/guidelines':
        return _fadeRoute(const GuidelineScreen());

      // Main Features
      case '/profile':
        return _fadeRoute(const ProfileScreen());
      case '/create-quiz':
        return _fadeRoute(const CreateQuizScreen());
      case '/all-dice':
        return _fadeRoute(const AllDiceScreen());

      // Settings Sub-screens
      case '/setting':
        return _fadeRoute(const SettingScreen());
      case '/profile-settings':
        return _fadeRoute(const ProfileSettingScreen());
      case '/privacy-settings':
        return _fadeRoute(const PrivacySettingScreen());
      case '/delete-account':
        return _fadeRoute(const DeleteAccountScreen());
      case '/language':
        return _fadeRoute(const LanguageScreen());
      case '/faq':
        return _fadeRoute(const FaqScreen());
      case '/terms':
        return _fadeRoute(const TermsConditionScreen());
      case '/privacy':
        return _fadeRoute(const PrivacyPolicyScreen());
      case '/user-type':
        return _fadeRoute(const UserTypeScreen());

      // Play Quiz Feature Flow
      case '/join_quiz':
        final quizData = settings.arguments as MyDiceData;
        return _fadeRoute(JoinQuizScreen(quizData: quizData));
      case '/enter_nickname':
        final quizData = settings.arguments as MyDiceData;
        return _fadeRoute(EnterNicknameScreen(quizData: quizData));
      case '/quiz_lobby':
        final args = settings.arguments as Map<String, dynamic>;
        final player = args['player'] as Player;
        final quizData = args['quizData'] as MyDiceData;
        return _fadeRoute(QuizLobbyScreen(player: player, quizData: quizData));
      case '/quiz_loading':
        final args = settings.arguments as Map<String, dynamic>;
        final player = args['player'] as Player;
        final quizData = args['quizData'] as MyDiceData;
        final questionIndex = args['questionIndex'] as int;
        return _fadeRoute(QuizLoadingScreen(
          player: player,
          quizData: quizData,
          questionIndex: questionIndex,
        ));
      case '/play_quiz':
        final args = settings.arguments as Map<String, dynamic>;
        final player = args['player'] as Player;
        final quizData = args['quizData'] as MyDiceData;
        final questionIndex = args['questionIndex'] as int;
        return _fadeRoute(PlayQuizScreen(
          player: player,
          quizData: quizData,
          questionIndex: questionIndex,
        ));
      case '/answer_feedback':
        final args = settings.arguments as Map<String, dynamic>;
        final player = args['player'] as Player;
        final quizData = args['quizData'] as MyDiceData;
        final questionIndex = args['questionIndex'] as int;
        final isCorrect = args['isCorrect'] as bool;
        return _fadeRoute(AnswerFeedbackScreen(
          player: player,
          quizData: quizData,
          questionIndex: questionIndex,
          isCorrect: isCorrect,
        ));
      case '/quiz_summary':
        final summary = settings.arguments as QuizSummary;
        return _fadeRoute(QuizSummaryScreen(summary: summary));
      case '/quiz_results':
        final player = settings.arguments as Player;
        return _fadeRoute(QuizResultsScreen(player: player));

      // Test screen
      case '/test':
        return _fadeRoute(const TestDataScreen());

      default:
        return _errorRoute();
    }
  }

  static PageRouteBuilder<dynamic> _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Page not found')),
        );
      },
    );
  }
}
