import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  final Color? backgroundColor;
  final List<Color>? gradientColors;

  const CustomOutlinedButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.color,
    this.backgroundColor,
    this.gradientColors,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double defaultWidth = screenWidth * 0.85;
    final double defaultHeight = screenWidth * 0.13;
    final double defaultFontSize = screenWidth * 0.042;
    final double defaultBorderRadius = screenWidth * 0.045;

    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: widget.height ?? defaultHeight,
            width: widget.width ?? defaultWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: widget.gradientColors != null
                  ? LinearGradient(
                      colors: widget.gradientColors!,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: widget.gradientColors == null
                  ? widget.backgroundColor ?? Colors.transparent
                  : null,
              border: Border.all(color: widget.color ?? AppColors.purple),
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? defaultBorderRadius,
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.color ?? AppColors.purple,
                fontSize: widget.fontSize ?? defaultFontSize,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins-normal',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
