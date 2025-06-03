import 'package:product_dice/core/config/flag_images.dart';

class Languages {
  final String label;
  final String? flagAsset;

  Languages({
    required this.label,
    this.flagAsset,
  });
}

// List of languages
List<Languages> languages = [
  Languages(label: 'EN', flagAsset: DiscoverFlags.en),
  Languages(label: 'FR', flagAsset: DiscoverFlags.fr),
  Languages(label: 'KH', flagAsset: DiscoverFlags.kh),
];
