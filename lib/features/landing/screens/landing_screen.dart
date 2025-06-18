import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
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
    const Center(child: Text('Discover Page')),
    const SizedBox.shrink(), // Empty widget since we navigate away immediately
    // Center(
    //   child: ElevatedButton(
    //     onPressed: _navigateToCreateQuiz,
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: const Color(0xFF8B5CF6),
    //       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //     ),
    //     child: const Text(
    //       'Create New Quiz',
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 16,
    //         fontWeight: FontWeight.w600,
    //       ),
    //     ),
    //   ),
    // ),
    const MyDiceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fabSize = screenWidth * 0.13 * 1.4; // Decide which AppBar to show
    PreferredSizeWidget? appBar;
    if (_currentIndex == 1) {
      // Discover tab -> new custom AppBar
      appBar = const AppBarDiscover();
    } else if (_currentIndex == 0) {
      // Default AppBarCustom
      appBar = AppBarCustom(
        iconAction: Icons.notifications_outlined,
        onAvatarTap: () {
          Navigator.pushNamed(context, '/profile');
        },
        imageLogo: const AssetImage(AppStartImages.logo),
      );
    } else if (_currentIndex == 3) {
      // My DICE tab -> no AppBar (it has its own custom AppBar)
      appBar = null;
    } else {
      // Fallback AppBar for other indices
      appBar = AppBar(
        title: const Text(''),
      );
    }

    return Scaffold(
      appBar: appBar,
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
              // Handle FAB tap
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
}
