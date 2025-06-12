import 'package:product_dice/core/config/flag_images.dart';

class Languages {
  final String? label;
  final String? flagAsset;
  final String? title;

  Languages({
    this.label,
    this.flagAsset,
    this.title,
  });
}

// List of languages
List<Languages> languages = [
  Languages(label: 'EN', title: 'English', flagAsset: DiscoverFlags.en),
  Languages(label: 'FR', title: 'Francais', flagAsset: DiscoverFlags.fr),
  Languages(label: 'KH', title: 'Khmer', flagAsset: DiscoverFlags.kh),
  Languages(label: 'ES', title: 'Espanol'),
  Languages(label: 'IL', title: 'Italian'),
];
