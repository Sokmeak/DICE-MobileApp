import 'package:flutter/material.dart';

class BoxDetail extends StatelessWidget {
  final String title;
  final String value;
  final bool showDivider;
  final BorderRadius? borderRadius;

  const BoxDetail({
    super.key,
    required this.title,
    required this.value,
    this.showDivider = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: borderRadius,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'poppins-normal',
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'poppins-normal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
