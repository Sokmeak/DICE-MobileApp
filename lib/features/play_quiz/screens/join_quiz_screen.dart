import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';
import 'package:product_dice/core/widgets/text_field_custom.dart';

class JoinQuizScreen extends StatelessWidget {
  final MyDiceData quizData;
  const JoinQuizScreen({Key? key, required this.quizData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGradient.colors.last.withOpacity(0.8),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              const Text(
                'PIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                ),
              ),
              const SizedBox(height: 40),
              ButtonCustom(
                text: 'Enter >',
                onPressed: () {
                  // In a real app, you would validate the PIN here.
                  // For now, we navigate directly to the nickname screen.
                  Navigator.pushNamed(context, '/enter_nickname', arguments: quizData);
                },
                color: Colors.blue.shade700,
                textColor: Colors.white,
                fontSize: 20,
              ),
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomButton(
                      context, Icons.pin_drop_outlined, 'Enter PIN'),
                  _buildBottomButton(
                      context, Icons.qr_code_scanner, 'Scan QR'),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(
      BuildContext context, IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {
        if (label == 'Enter PIN') {
           Navigator.pushNamed(context, '/enter_nickname', arguments: quizData);
        }
        // Add QR scan logic here
      },
      icon: Icon(icon, color: Colors.white, size: 28),
      label: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 18)),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
