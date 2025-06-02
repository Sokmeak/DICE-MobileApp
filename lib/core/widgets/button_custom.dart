import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final double elevation;
  final Color? shadowColor;
  final VoidCallback onPressed;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double iconSize;
  final double fontSize;
  final List<Color>? gradientColors;

  const ButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 20,
    this.color = const Color(0xFFEE6019),
    this.textColor = Colors.white,
    this.leftIcon,
    this.rightIcon,
    this.iconSize = 20,
    this.fontSize = 16,
    this.borderColor,
    this.borderWidth = 1.0,
    this.elevation = 4.0,
    this.shadowColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: gradientColors == null ? color : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
          boxShadow: [
            if (elevation > 0)
              BoxShadow(
                color: shadowColor ?? Colors.black26,
                blurRadius: elevation,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leftIcon != null) ...[
                Icon(leftIcon, color: textColor, size: iconSize),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontFamily: 'poppins-normal',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (rightIcon != null) ...[
                const SizedBox(width: 8),
                Icon(rightIcon, color: textColor, size: iconSize),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
