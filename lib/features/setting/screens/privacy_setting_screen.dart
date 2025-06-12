import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';
import 'package:product_dice/features/setting/widgets/setting_switch_tile.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  bool isShareWithYou = false;
  bool isFeature = false;
  bool isShareWithOther = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(
        title: 'Privacy Setting',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy
              Text(
                'Privacy',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'poppins-normal',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Divider(
                        height: 1,
                        color: AppColors.grey,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Email me when someone:',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'poppins-normal',
                          fontWeight: FontWeight.w500,
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
                              title: 'Shares a DICE with you',
                              value: isShareWithYou,
                              onChanged: (val) =>
                                  setState(() => isShareWithYou = val),
                            ),
                            SettingSwitchTile(
                              title: 'Features your DICE to other users',
                              value: isFeature,
                              onChanged: (val) =>
                                  setState(() => isFeature = val),
                              showDivider: false,
                            ),
                          ],
                        ),
                      ),
                    ],
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
