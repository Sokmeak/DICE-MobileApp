import 'package:flutter/material.dart';

class MorningBanner extends StatelessWidget {
  final String greeting;
  final String subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  const MorningBanner({
    super.key,
    this.greeting = 'Good Morning',
    this.subtitle = 'Ready to learn something new?',
    this.icon = Icons.wb_sunny,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        height: size.height * 0.12,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8B5CF6),
              Color(0xFF3B82F6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8B5CF6).withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins-normal',
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: size.width * 0.035,
                        fontFamily: 'poppins-normal',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.15,
                height: size.width * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: size.width * 0.08,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
