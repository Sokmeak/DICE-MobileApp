import 'package:flutter/material.dart';

class CategoriesEdit extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const CategoriesEdit(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.02),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE7E7E7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: size.height * 0.03,
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              title,
              style: TextStyle(
                fontSize: size.height * 0.015,
                fontWeight: FontWeight.normal,
                fontFamily: 'poppins-normal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
