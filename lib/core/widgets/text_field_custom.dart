import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool isDarkMode;
  final Color? backgroundColor;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final String? Function(String?)? validator;

  const TextFieldCustom({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.label,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.isDarkMode = false,
    this.backgroundColor,
    this.prefixIconWidget,
    this.suffixIconWidget,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isDarkMode ? Colors.grey.shade700 : const Color(0xFFE1E1E1);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final hintColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(
          color: textColor,
          fontFamily: 'poppins-normal',
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: textColor,
            fontFamily: 'poppins-normal',
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontFamily: 'poppins-normal',
          ),
          prefixIcon: prefixIconWidget ??
              (prefixIcon != null ? Icon(prefixIcon, color: textColor) : null),
          suffixIcon: suffixIconWidget ??
              (suffixIcon != null ? Icon(suffixIcon, color: textColor) : null),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: backgroundColor ??
              (isDarkMode ? Colors.grey.shade900 : const Color(0xFFF6F6F6)),
        ),
      ),
    );
  }
}
