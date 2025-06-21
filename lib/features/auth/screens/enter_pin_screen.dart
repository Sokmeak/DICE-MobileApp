import 'package:flutter/material.dart';
import 'package:dice_app/core/theme/colors.dart';
import 'package:dice_app/core/routes/app_routes.dart' as routes;

class EnterPinScreen extends StatelessWidget {
  const EnterPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join DICE'),
        backgroundColor: AppColors.skyBlue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.white),
            onPressed: () {
              // Add close functionality if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'PIN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, color: AppColors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: 'Enter PIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Use the route constant from app_routes.dart
                Navigator.pushNamed(context, routes.nicknameRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Enter',
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
