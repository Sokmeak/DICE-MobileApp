import 'package:flutter/material.dart';

class PremiumCard extends StatelessWidget {
  final String? imageUrl;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const PremiumCard({
    super.key,
    this.imageUrl,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.25,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade800,
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 24,
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 24,
                ),
              ),
      ),
    );
  }
}
