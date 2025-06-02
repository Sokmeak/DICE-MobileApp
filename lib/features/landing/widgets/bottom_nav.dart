import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizes (adjust these multipliers as you like)
    final iconSize = screenWidth * 0.06; // e.g., 24 at 400 width
    final fontSize = screenWidth * 0.035; // e.g., ~14 at 400 width
    final spacingBetween = screenWidth * 0.015; // space between icon and label

    const List<Color> activeGradientColors = AppColors.gradientColors;
    const Color activeTextColor = AppColors.black;
    const Color inactiveColor = AppColors.grey;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: SizedBox(
        height: iconSize +
            fontSize +
            spacingBetween +
            20, // dynamic height with some padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home_filled,
              label: 'Home',
              active: widget.currentIndex == 0,
              activeGradientColors: activeGradientColors,
              activeTextColor: activeTextColor,
              inactiveColor: inactiveColor,
              iconSize: iconSize,
              fontSize: fontSize,
              spacing: spacingBetween,
              onTap: () => widget.onTap(0),
            ),
            _buildNavItem(
              icon: Icons.explore_outlined,
              label: 'Discover',
              active: widget.currentIndex == 1,
              activeGradientColors: activeGradientColors,
              activeTextColor: activeTextColor,
              inactiveColor: inactiveColor,
              iconSize: iconSize,
              fontSize: fontSize,
              spacing: spacingBetween,
              onTap: () => widget.onTap(1),
            ),
            SizedBox(width: iconSize * 2),
            _buildNavItem(
              icon: Icons.add_circle_outline,
              label: 'Create',
              active: widget.currentIndex == 2,
              activeGradientColors: activeGradientColors,
              activeTextColor: activeTextColor,
              inactiveColor: inactiveColor,
              iconSize: iconSize,
              fontSize: fontSize,
              spacing: spacingBetween,
              onTap: () => widget.onTap(2),
            ),
            _buildNavItem(
              icon: Icons.menu_book_rounded,
              label: 'My DICE',
              active: widget.currentIndex == 3,
              activeGradientColors: activeGradientColors,
              activeTextColor: activeTextColor,
              inactiveColor: inactiveColor,
              iconSize: iconSize,
              fontSize: fontSize,
              spacing: spacingBetween,
              onTap: () => widget.onTap(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool active,
    required List<Color> activeGradientColors,
    required Color activeTextColor,
    required Color inactiveColor,
    required double iconSize,
    required double fontSize,
    required double spacing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          active
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: activeGradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Icon(icon, color: Colors.white, size: iconSize),
                )
              : Icon(icon, color: inactiveColor, size: iconSize),
          SizedBox(height: spacing),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'poppins-normal',
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              color: active ? activeTextColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
