import 'package:flutter/material.dart';
import 'package:product_dice/core/config/get_start_images.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/utils/validation_log.dart';
import 'package:product_dice/core/widgets/button_custom.dart';
import 'package:product_dice/core/widgets/text_field_custom.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.1,
        ),
        child: Form(
          key: _formKey,
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
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins-normal',
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Log in to your account to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                  fontFamily: 'poppins-normal',
                ),
              ),
              const SizedBox(height: 20),

              // Email field with SVG icon
              TextFieldCustom(
                label: 'Email',
                validator: ValidationLog.validateEmail,
                controller: emailController,
                isPassword: false,
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 10),

              // Password field with toggle visibility
              TextFieldCustom(
                label: 'Password',
                validator: ValidationLog.validatePassword,
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.purple,
                      fontFamily: 'poppins-normal',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Sign In button
              ButtonCustom(
                text: 'Sign In',
                gradientColors: AppColors.gradientColors,
                textColor: Colors.white,
                width: double.infinity,
                height: 50,
                elevation: 0,
                borderRadius: 10,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid
                    Navigator.of(context).pushNamed('/landing');
                  } else {
                    // Invalid fields will show error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please check your password or email!'),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey,
                      fontFamily: 'poppins-normal',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.purple,
                        fontFamily: 'poppins-normal',
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
      ),
    );
  }
}
