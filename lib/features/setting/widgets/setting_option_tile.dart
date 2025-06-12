import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';

class SettingOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const SettingOptionTile({
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
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: size.height * 0.018,
              fontFamily: 'poppins-normal',
            ),
          ),
          onTap: onTap,
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
