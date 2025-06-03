import 'package:flutter/material.dart';
import 'package:product_dice/core/data/discover_data.dart';

class CardImage extends StatelessWidget {
  final DiscoverData data;
  const CardImage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image(
        image: data.image,
        width: double.infinity,
        height: height * 0.15,
        fit: BoxFit.cover,
      ),
    );
  }
}
