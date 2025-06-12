import 'package:flutter/material.dart';
import 'package:product_dice/features/setting/Controller/setting_controller.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';
import 'package:product_dice/features/setting/widgets/setting_navigation_tile.dart';
import 'package:product_dice/features/setting/widgets/setting_option_tile.dart';
import 'package:product_dice/features/setting/widgets/setting_switch_tile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isMusicOn = false;
  bool isSoundOn = false;

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'Profile Settings',
      'Privacy Settings',
      'Delete Account',
      'Log Out',
    ];

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(
        title: 'Settings',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E7E7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: List.generate(options.length, (index) {
                    final option = options[index];
                    return SettingOptionTile(
                      title: option,
                      showDivider: index != options.length - 1,
                      onTap: () => SettingController.handleTap(context, option),
                    );
                  }),
                ),
              ),

              // General
              SizedBox(height: size.height * 0.02),
              Text(
                'General',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
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
                child: Column(
                  children: [
                    SettingNavigationTile(
                      title: 'Languages',
                      showDivider: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/language');
                      },
                    ),
                  ],
                ),
              ),

              // Music
              SizedBox(height: size.height * 0.02),
              Text(
                'Music',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
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
                child: Column(
                  children: [
                    SettingSwitchTile(
                      title: 'Music',
                      value: isMusicOn,
                      onChanged: (val) => setState(() => isMusicOn = val),
                    ),
                    SettingSwitchTile(
                      title: 'Sound Effects',
                      value: isSoundOn,
                      onChanged: (val) => setState(() => isSoundOn = val),
                      showDivider: false,
                    ),
                  ],
                ),
              ),

              // Help
              SizedBox(height: size.height * 0.02),
              Text(
                'Help',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
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
                child: Column(
                  children: [
                    SettingOptionTile(
                      title: 'Version 1.0.0',
                      onTap: () {},
                      showDivider: true,
                    ),
                    SettingNavigationTile(
                      title: 'FAQ',
                      showDivider: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/FAQ');
                      },
                    ),
                  ],
                ),
              ),

              // Legal
              SizedBox(height: size.height * 0.02),
              Text(
                'Legal',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
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
                child: Column(
                  children: [
                    SettingNavigationTile(
                      title: 'Terms and Conditions',
                      showDivider: true,
                      onTap: () {
                        Navigator.pushNamed(context, '/terms');
                      },
                    ),
                    SettingNavigationTile(
                      title: 'Privacy Policy',
                      showDivider: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy');
                      },
                    ),
                  ],
                ),
              ),

              // User Type
              SizedBox(height: size.height * 0.02),
              Text(
                'User Type',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
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
                child: Column(
                  children: [
                    SettingNavigationTile(
                      title: 'Student',
                      showDivider: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/student');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
