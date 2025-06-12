import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';
import 'package:product_dice/features/setting/widgets/switch_tile.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  bool isShareWithYou = false;
  bool isFeature = false;
  bool isShareWithOther = false;
  bool isFavorite = false;

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

                      // Email
                      Text(
                        'Email me when someone:',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'poppins-normal',
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Enable
                      SizedBox(height: size.height * 0.02),
                      SwitchTile(
                        title: Text(
                          'Shared your DICE with you',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontFamily: 'poppins-normal',
                          ),
                        ),
                        value: isShareWithYou,
                        onChanged: (value) => setState(
                          () => isShareWithYou = value,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SwitchTile(
                        title: Text(
                          'Featured your DICE with users',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontFamily: 'poppins-normal',
                          ),
                        ),
                        value: isFeature,
                        onChanged: (value) => setState(
                          () => isFeature = value,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SwitchTile(
                        title: Text(
                          'Shared your DICE with others',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontFamily: 'poppins-normal',
                          ),
                        ),
                        value: isShareWithOther,
                        onChanged: (value) => setState(
                          () => isShareWithOther = value,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SwitchTile(
                        title: Text(
                          'Favorites your DICE ',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontFamily: 'poppins-normal',
                          ),
                        ),
                        value: isFavorite,
                        onChanged: (value) => setState(
                          () => isFavorite = value,
                        ),
                      ),
                    ],
                  ),
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
                        'Privacy and Marketing',
                        style: TextStyle(
                          fontSize: size.height * 0.018,
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

                      // Enable
                      SwitchTile(
                        title: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: size.height * 0.018,
                              color: Colors.black,
                              fontFamily: 'poppins-normal',
                            ),
                            children: [
                              const TextSpan(
                                  text: 'I have read and agree to the '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate or show Terms
                                  },
                              ),
                            ],
                          ),
                        ),
                        value: isShareWithYou,
                        onChanged: (value) =>
                            setState(() => isShareWithYou = value),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SwitchTile(
                        title: Text(
                          'I have read and agree to the Privacy Policy',
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            fontFamily: 'poppins-normal',
                          ),
                        ),
                        value: isFeature,
                        onChanged: (value) => setState(
                          () => isFeature = value,
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
