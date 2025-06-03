import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';

class HorizontalIconSeeAll extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color? colorIcon;
  final VoidCallback? onPressed;

  const HorizontalIconSeeAll({
    super.key,
    this.icon,
    required this.title,
    this.onPressed,
    this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: colorIcon),
            SizedBox(width: screenWidth * 0.02),
            Text(
              title,
              style: TextStyle(
                fontSize: screenHeight * 0.018,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins-normal',
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'See All',
            style: TextStyle(
              fontFamily: 'poppins-normal',
              color: AppColors.grey,
              fontSize: screenHeight * 0.015,
            ),
          ),
        ),
      ],
    );
  }
}
