import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';
import 'package:product_dice/features/home/widgets/card_my_dice.dart';
import 'package:product_dice/core/theme/colors.dart';

class MyDiceScreen extends StatefulWidget {
  const MyDiceScreen({super.key});

  @override
  State<MyDiceScreen> createState() => _MyDiceScreenState();
}

class _MyDiceScreenState extends State<MyDiceScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/landing', (route) => false),
        ),
        title: const Text(
          'DICE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Add your notification or menu action
            },
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to see all recent quizzes
                      Navigator.pushNamed(context, '/all-dice');
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: AppColors.purple,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),

              // Recent quiz cards
              SizedBox(
                height: height * 0.30, // adjust based on your card height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(), // for smooth scrolling
                  itemCount: myDiceData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final data = myDiceData[index];
                    return SizedBox(
                      width: width * 0.7,
                      child: CardMyDice(data: data),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),

              // Menu options
              _buildMenuOption(
                icon: Icons.person_outline,
                title: 'Your DICE',
                iconColor: AppColors.purple,
                onTap: () {
                  // Navigate to Your DICE
                  Navigator.pushNamed(context, '/all-dice');
                },
              ),
              SizedBox(height: height * 0.01),
              _buildMenuOption(
                icon: Icons.star_outline,
                title: 'Favorites',
                iconColor: AppColors.purple,
                onTap: () {
                  // Navigate to Favorites
                },
              ),
              SizedBox(height: height * 0.01),
              _buildMenuOption(
                icon: Icons.share_outlined,
                title: 'Shared',
                iconColor: AppColors.purple,
                onTap: () {
                  // Navigate to Shared
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.005,
        ),
        leading: Icon(
          icon,
          color: iconColor,
          size: width * 0.06,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.grey,
          size: width * 0.04,
        ),
        onTap: onTap,
      ),
    );
  }
}
