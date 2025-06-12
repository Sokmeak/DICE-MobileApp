import 'package:flutter/material.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    TextStyle headingStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size.height * 0.022,
      fontFamily: 'poppins-normal',
    );

    TextStyle bodyStyle = TextStyle(
      fontSize: size.height * 0.019,
      fontFamily: 'poppins-normal',
      height: 1.5,
    );

    return Scaffold(
      appBar: const AppBarSetting(title: 'Privacy Policy'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DICE Privacy Policy', style: headingStyle),
              SizedBox(height: size.height * 0.02),

              // Section 1
              SectionHeading('1. Information We Collect', headingStyle),
              SectionBullet(
                  'Personal Information (e.g., username, email)', bodyStyle),
              SectionBullet(
                  'Usage Data (e.g., quiz performance, features used)',
                  bodyStyle),
              SectionBullet(
                  'Device Information (e.g., OS, location with permission)',
                  bodyStyle),

              SizedBox(height: size.height * 0.025),

              // Section 2
              SectionHeading('2. How We Use Your Information', headingStyle),
              SectionBullet(
                  'Improve app performance and personalize experience',
                  bodyStyle),
              SectionBullet(
                  'Provide customer support and analytics', bodyStyle),
              SectionBullet(
                  'Enforce our terms and comply with legal obligations',
                  bodyStyle),

              SizedBox(height: size.height * 0.025),

              // Section 3
              SectionHeading('3. Sharing of Information', headingStyle),
              SectionBullet(
                  'Shared only with services required for app functionality',
                  bodyStyle),
              SectionBullet(
                  'Never sold to third parties for marketing', bodyStyle),

              SizedBox(height: size.height * 0.025),

              // Section 4
              SectionHeading('4. Data Security', headingStyle),
              SectionBullet(
                  'We implement security measures to protect your data',
                  bodyStyle),
              SectionBullet(
                  'No method is 100% secure, but we strive to use best practices',
                  bodyStyle),

              SizedBox(height: size.height * 0.025),

              // Section 5
              SectionHeading('5. Your Rights & Choices', headingStyle),
              SectionBullet(
                  'You can view, edit, or delete your information anytime',
                  bodyStyle),
              SectionBullet('You can contact us for any data-related requests',
                  bodyStyle),

              SizedBox(height: size.height * 0.025),

              // Section 6
              SectionHeading('6. Children’s Privacy', headingStyle),
              SectionBullet(
                  'Our app is not intended for children under 13', bodyStyle),
              SectionBullet(
                  'We do not knowingly collect personal info from minors',
                  bodyStyle),

              SizedBox(height: size.height * 0.025),

              // Section 7
              SectionHeading('7. Changes to this Policy', headingStyle),
              SectionBullet(
                  'We may update this policy, and changes will be posted here',
                  bodyStyle),
              SectionBullet(
                  'Continued use implies acceptance of the new policy',
                  bodyStyle),

              SizedBox(height: size.height * 0.04),

              Center(
                child: Text(
                  'Last Updated: 27/03/2025\nContact: support@DICE.com',
                  style: bodyStyle.copyWith(fontSize: size.height * 0.017),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget SectionHeading(String title, TextStyle style) {
    return Text(title, style: style);
  }

  Widget SectionBullet(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
