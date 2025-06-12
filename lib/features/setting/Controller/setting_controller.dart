import 'package:flutter/material.dart';

class SettingController {
  static void handleTap(BuildContext context, String option) {
    switch (option) {
      case 'Profile Settings':
        Navigator.pushNamed(context, '/profile-settings');
        break;
      case 'Privacy Settings':
        Navigator.pushNamed(context, '/privacy-settings');
        break;
      case 'Delete Account':
        Navigator.pushNamed(context, '/delete-account');
        break;
      case 'Log Out':
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle logout logic
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child:
                    const Text('Log Out', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
        break;
    }
  }
}
