import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';
import 'package:product_dice/core/widgets/text_field_custom.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isShowPassword = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(
        title: 'Profile Setting',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
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
                        'User Information',
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

                      // Username
                      SizedBox(height: size.height * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'poppins-normal',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFieldCustom(
                            hintText: 'Username',
                            controller: _usernameController,
                            label: 'Username',
                            prefixIconWidget: Icon(
                              Icons.person_rounded,
                              color: AppColors.grey,
                              size: size.height * 0.025,
                            ),
                          ),
                        ],
                      ),

                      // Name
                      SizedBox(height: size.height * 0.01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'poppins-normal',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFieldCustom(
                            hintText: 'Name',
                            controller: _nameController,
                            label: 'Name',
                            prefixIconWidget: Icon(
                              Icons.person_rounded,
                              color: AppColors.grey,
                              size: size.height * 0.025,
                            ),
                          ),
                        ],
                      ),

                      // Name
                      SizedBox(height: size.height * 0.01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'poppins-normal',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFieldCustom(
                            hintText: 'Email',
                            controller: _emailController,
                            label: 'Email',
                            prefixIconWidget: Icon(
                              Icons.email_rounded,
                              color: AppColors.grey,
                              size: size.height * 0.025,
                            ),
                          ),
                        ],
                      ),

                      // Password
                      SizedBox(height: size.height * 0.01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'poppins-normal',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFieldCustom(
                            hintText: 'Password',
                            controller: _passwordController,
                            label: 'Password',
                            prefixIconWidget: Icon(
                              Icons.password_rounded,
                              color: AppColors.grey,
                              size: size.height * 0.025,
                            ),
                            isPassword: !isShowPassword,
                            suffixIconWidget: IconButton(
                              icon: Icon(
                                isShowPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.grey,
                                size: size.height * 0.025,
                              ),
                              onPressed: () {
                                setState(() {
                                  isShowPassword = !isShowPassword;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Save
              SizedBox(height: size.height * 0.02),
              ButtonCustom(
                text: 'Save',
                onPressed: () {
                  Flushbar(
                    message: 'Changes saved successfully!',
                    backgroundColor: Colors.greenAccent[700]!,
                    duration: const Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    margin: const EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(8),
                    animationDuration: const Duration(milliseconds: 300),
                    messageText: const Text(
                      'Changes saved successfully!',
                      style: TextStyle(
                        fontFamily: 'poppins-medium',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ).show(context);
                },
                gradientColors: AppColors.gradientColors,
                borderRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
