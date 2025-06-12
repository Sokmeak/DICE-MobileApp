import 'package:flutter/material.dart';
import 'package:product_dice/core/data/languages.dart';
import 'package:product_dice/features/discover/widgets/search.dart';

class AppBarDiscover extends StatefulWidget implements PreferredSizeWidget {
  const AppBarDiscover({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  State<AppBarDiscover> createState() => _AppBarDiscoverState();
}

class _AppBarDiscoverState extends State<AppBarDiscover> {
  Languages _selectedLanguage = languages.first;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isMediumScreen = size.width < 480;

    return Material(
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      child: SafeArea(
        child: Container(
          height: widget.preferredSize.height,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            children: [
              // Search bar
              Expanded(
                child: SearchCustom(
                  hintText:
                      isSmallScreen ? 'Search...' : 'Find a DICE about...',
                  onChanged: (value) {
                    // Handle search input
                  },
                ),
              ),

              SizedBox(width: size.width * 0.02),

              // Language Dropdown
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Languages>(
                    value: _selectedLanguage,
                    icon:
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                    dropdownColor: Colors.white,
                    onChanged: (newLang) {
                      if (newLang != null) {
                        setState(() {
                          _selectedLanguage = newLang;
                        });
                        // Add your language change logic here
                      }
                    },
                    items: languages.map((lang) {
                      return DropdownMenuItem<Languages>(
                        value: lang,
                        child: Row(
                          children: [
                            if (lang.flagAsset != null) ...[
                              Image.asset(
                                lang.flagAsset!,
                                width: 20,
                                height: 14,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: size.width * 0.02),
                            ],
                            if (!isSmallScreen)
                              Text(
                                lang.label ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMediumScreen ? 14 : 16,
                                  color: Colors.black54,
                                  fontFamily: 'poppins-normal',
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
