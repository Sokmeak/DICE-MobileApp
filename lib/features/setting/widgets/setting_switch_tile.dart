import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';

class SettingSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const SettingSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textScale = size.width / 375;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: size.height * 0.018 * textScale,
                      fontFamily: 'poppins-normal',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Switch(
                  activeColor: Colors.greenAccent[700],
                  value: value,
                  onChanged: onChanged,
                ),
              ],
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
