import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';

class SettingNavigationTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const SettingNavigationTile({
    super.key,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: SizedBox(
            height: size.height * 0.06,
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: size.height * 0.018,
                      fontFamily: 'poppins-normal',
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      size: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            color: AppColors.grey,
          ),
      ],
    );
  }
}
