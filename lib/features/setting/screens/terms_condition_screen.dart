import 'package:flutter/material.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

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
      appBar: const AppBarSetting(title: 'Terms & Conditions'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Terms & Conditions
              Text('Terms and Conditions for QuizMaster Mobile App',
                  style: headingStyle),
              SizedBox(height: size.height * 0.02),

              Text('1. Acceptance of Terms', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                'By downloading, installing, or using the DICE mobile application, you agree to be bound by these Terms and Conditions. If you do not agree with these terms, please do not use the application.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('2. User Account and Eligibility', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '2.1 Users must be at least 13 years old to create an account and use the application.\n'
                '2.2 You are responsible for maintaining the confidentiality of your account credentials.\n'
                '2.3 You agree to provide accurate and current information during registration.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('3. User Conduct', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '3.1 Users agree to:\n'
                '• Use the app for its intended purpose of educational entertainment\n'
                '• Respect other users and avoid offensive or inappropriate content\n'
                '• Not attempt to hack, manipulate, or exploit the app\'s systems\n'
                '• Not create multiple accounts to gain unfair advantages',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('4. Intellectual Property', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '4.1 All content within the app, including quiz questions, designs, and graphics, are the property of DICE mobile.\n'
                '4.2 Users may not reproduce, distribute, or create derivative works from the app\'s content without explicit written permission.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('5. User-Generated Content', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '5.1 Users may create and share quiz content subject to the following conditions:\n'
                '• Content must be original or properly attributed\n'
                '• Content must not violate copyright laws\n'
                '• Offensive, discriminatory, or inappropriate content is strictly prohibited\n'
                '5.2 By creating content, users grant DICE mobile a non-exclusive, worldwide license to use, modify, and distribute the content.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('6. Privacy and Data Protection', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '6.1 User data will be collected and processed in accordance with our Privacy Policy.\n'
                '6.2 We may collect usage data, performance metrics, and personal information as outlined in the Privacy Policy.\n'
                '6.3 Users can opt-out of certain data collection in the app settings.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('7. In-App Purchases and Subscriptions',
                  style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '7.1 Some features may require in-app purchases or subscriptions.\n'
                '7.2 Prices are clearly displayed and subject to change.\n'
                '7.3 Subscriptions can be managed and canceled through the app or device settings.\n'
                '7.4 Refund policies are subject to the terms of the app store platform.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('8. Limitation of Liability', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '8.1 DICE mobile is not liable for:\n'
                '• Any indirect, incidental, or consequential damages\n'
                '• Loss of data or interruption of service\n'
                '• Content created or shared by users\n'
                '8.2 The app is provided "as is" without warranties of any kind.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('9. Modification of Terms', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '9.1 DICE mobile reserves the right to modify these terms at any time.\n'
                '9.2 Continued use of the app after changes constitutes acceptance of new terms.\n'
                '9.3 Users will be notified of significant changes via app notification or email.',
                style: bodyStyle,
              ),
              SizedBox(height: size.height * 0.04),
              Text('10. Termination', style: headingStyle),
              SizedBox(height: size.height * 0.015),
              Text(
                '10.1 DICE mobile may suspend or terminate user accounts for:\n'
                '• Violation of these terms\n'
                '• Fraudulent activity\n'
                '• Repeated inappropriate behavior\n'
                '10.2 Users may delete their account through app settings at any time.',
                style: bodyStyle,
              ),
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
}
