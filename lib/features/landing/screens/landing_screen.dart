import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
import 'package:product_dice/features/discover/screens/discover_screen.dart'; // Add this import
import 'package:product_dice/features/discover/widgets/app_bar_discover.dart';
import 'package:product_dice/features/home/screens/home_screen.dart';
import 'package:product_dice/features/home/widgets/app_bar.dart';
import 'package:product_dice/features/landing/widgets/bottom_nav.dart';
import 'package:product_dice/features/createquiz/screens/create_quiz_screen.dart';
import 'package:product_dice/features/mydice/screens/my_dice_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == 2) {
      // Navigate to CreateQuiz screen when index 2 is tapped
      _navigateToCreateQuiz();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  // Navigation method to CreateQuizScreen
  void _navigateToCreateQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateQuizScreen(),
      ),
    );
  }

  // List of pages
  late final List<Widget> _pages = [
    const HomeScreen(),
    const DiscoverScreen(), // Replace placeholder with actual DiscoverScreen
    const SizedBox.shrink(), // Empty widget since we navigate away immediately
    const MyDiceScreen(),
  ];

  // Method to build appropriate AppBar based on current index
  PreferredSizeWidget? _buildAppBar() {
    switch (_currentIndex) {
      case 0:
        // Home tab
        return AppBarCustom(
          iconAction: Icons.notifications_outlined,
          onAvatarTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          imageLogo: const AssetImage(AppStartImages.logo),
        );
      case 1:
        // Discover tab - no AppBar here since DiscoverScreen has its own
        return null;
      case 3:
        // My DICE tab - no AppBar since it has its own custom AppBar
        return null;
      default:
        // Fallback AppBar for other indices
        return AppBar(
          title: const Text(''),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fabSize = screenWidth * 0.13 * 1.4;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: fabSize,
        height: fabSize,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(fabSize / 2),
            onTap: () {
              // Handle FAB tap - maybe join a quiz or show join dialog
              _handleJoinAction();
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  AppStartImages.join,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Handle floating action button tap
  void _handleJoinAction() {
    // TODO: Implement join functionality
    // This could show a dialog to enter a quiz code, or navigate to a join screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Quiz'),
        content: const Text('Enter quiz code to join'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement join logic
              Navigator.pop(context);
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}
