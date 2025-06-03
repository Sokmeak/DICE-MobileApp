import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardBannerCarousel extends StatelessWidget {
  final List<ImageProvider> images;

  const CardBannerCarousel({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive height
    final carouselHeight = screenHeight * 0.22;

    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIdx) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          child: Container(
            width: double.infinity,
            height: carouselHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: carouselHeight,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.88,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
