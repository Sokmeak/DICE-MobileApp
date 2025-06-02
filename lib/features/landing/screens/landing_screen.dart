import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
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
    const Center(child: Text('Home Page')),
    const Center(child: Text('Discover Page')),
    const Center(child: Text('Create Page')),
    const Center(child: Text('My DICE Page')),
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive FAB size (adjust these multipliers as you like)
    final fabSize = screenWidth * 0.13 * 1.4;

    return Scaffold(
      appBar: AppBar(title: const Text('Landing Screen')),
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
            onTap: () {},
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
