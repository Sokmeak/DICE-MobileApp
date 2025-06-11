import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
import 'package:product_dice/features/discover/widgets/app_bar_discover.dart';
import 'package:product_dice/features/home/screens/home_screen.dart';
import 'package:product_dice/features/home/widgets/app_bar.dart';
import 'package:product_dice/features/landing/widgets/bottom_nav.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // List of pages
  late final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text('Discover Page')),
    const Center(child: Text('Create Page')),
    const Center(child: Text('My DICE Page')),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fabSize = screenWidth * 0.13 * 1.4;

    // Decide which AppBar to show
    PreferredSizeWidget appBar;
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
