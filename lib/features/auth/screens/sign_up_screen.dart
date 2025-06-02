import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';
import 'package:product_dice/core/widgets/text_field_custom.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.06,
        ),
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: 'logo-hero',
                child: Image.asset(
                  AppStartImages.logo,
                  height: screenHeight * 0.12,
                  width: screenHeight * 0.12,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              'Welcome to Dice!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontFamily: 'poppins-normal',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign up to get started with Dice',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                fontFamily: 'poppins-normal',
              ),
            ),
            const SizedBox(height: 20),

            // Name field
            TextFieldCustom(
              label: 'Name',
              controller: nameController,
              isPassword: false,
              hintText: 'Enter your name',
              prefixIcon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 10),

            // Email field
            TextFieldCustom(
              label: 'Email',
              controller: emailController,
              isPassword: false,
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 10),

            // Password field with toggle visibility
            TextFieldCustom(
              label: 'Password',
              controller: passwordController,
              isPassword: !isPasswordVisible,
              hintText: 'Enter your password',
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: Icons.password_rounded,
              suffixIconWidget: IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Confirm Password field
            TextFieldCustom(
              label: 'Confirm Password',
              controller: passwordController,
              isPassword: !isPasswordVisible,
              hintText: 'Confirm your password',
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: Icons.password_rounded,
              suffixIconWidget: IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),
            // Sign In button
            ButtonCustom(
              text: 'Sign Up',
              gradientColors: AppColors.gradientColors,
              textColor: Colors.white,
              width: double.infinity,
              height: 50,
              elevation: 0,
              borderRadius: 10,
              onPressed: () {
                Navigator.of(context).pushNamed('/signin');
              },
            ),
            const SizedBox(height: 20),

            // Agree with term or condition
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: AppColors.purple,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Agree with our ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.purple,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.purple,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/landing');
              },
              child: const Text(
                'Skip to Home',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.purple,
                  fontFamily: 'poppins-normal',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
