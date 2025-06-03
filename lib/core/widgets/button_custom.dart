import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final double elevation;
  final Color? shadowColor;
  final VoidCallback onPressed;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? iconSize;
  final double? fontSize;
  final List<Color>? gradientColors;

  const ButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius = 20,
    this.color = const Color(0xFFEE6019),
    this.textColor = Colors.white,
    this.leftIcon,
    this.rightIcon,
    this.iconSize,
    this.fontSize,
    this.borderColor,
    this.borderWidth = 1.0,
    this.elevation = 4.0,
    this.shadowColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive fallback values
    final resolvedWidth = width ?? screenWidth * 0.8;
    final resolvedHeight = height ?? screenWidth * 0.12;
    final resolvedFontSize = fontSize ?? screenWidth * 0.04;
    final resolvedIconSize = iconSize ?? screenWidth * 0.05;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: resolvedWidth,
        height: resolvedHeight,
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
                Icon(leftIcon, color: textColor, size: resolvedIconSize),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: resolvedFontSize,
                    fontFamily: 'poppins-normal',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (rightIcon != null) ...[
                const SizedBox(width: 8),
                Icon(rightIcon, color: textColor, size: resolvedIconSize),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
