import 'package:flutter/material.dart';
import 'package:product_dice/core/data/languages.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadDefaultLanguage();
  }

  Future<void> _loadDefaultLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selected_language') ?? 'English';
    });
  }

  Future<void> _saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', lang);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(title: 'Languages'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.02,
        ),
        child: Column(
          children: languages.map((lang) {
            final isSelected = selectedLanguage == lang.title;

            return Container(
              margin: EdgeInsets.only(bottom: size.height * 0.015),
              decoration: BoxDecoration(
                color: const Color(0xFFE7E7E7),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListTile(
                leading: lang.flagAsset != null
                    ? Image.asset(
                        lang.flagAsset!,
                        width: size.width * 0.055,
                        height: size.height * 0.055,
                        fit: BoxFit.contain,
                      )
                    : const Icon(Icons.flag_outlined),
                title: Text(
                  lang.title == selectedLanguage
                      ? '${lang.title} (Default)'
                      : lang.title ?? '',
                  style: const TextStyle(
                    fontFamily: 'poppins-medium',
                    fontSize: 16,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: Colors.black,
                        size: size.height * 0.03,
                      )
                    : const SizedBox.shrink(),
                onTap: () {
                  setState(() {
                    selectedLanguage = lang.title;
                  });
                  _saveLanguage(lang.title ?? '');
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
