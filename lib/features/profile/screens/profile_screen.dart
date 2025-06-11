import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:product_dice/features/profile/widgets/appbar_profile.dart';
import 'package:product_dice/features/profile/widgets/box_detail.dart';
import 'package:product_dice/features/profile/widgets/pop_up_edit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imagePath; // Add this line to define imagePath

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarProfile(
        onEditTap: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "Dismiss",
            barrierColor: Colors.black.withOpacity(0.2),
            pageBuilder: (context, animation, secondaryAnimation) {
              return Stack(
                children: [
                  // Blur Background
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0), // required for BackdropFilter
                    ),
                  ),
                  // Centered Modal
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: const PopUpEdit(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        onSettingTap: () {},
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar
                    Container(
                      height: size.height * 0.13,
                      width: size.height * 0.13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE7E7E7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: imagePath != null
                            ? Image.asset(
                                imagePath!,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text(
                                  "KS", // Replace with user initials or dynamic value
                                  style: TextStyle(
                                    fontSize: size.height * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),

                    // Username
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins-normal',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),

                // Add New Account Button
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},

                      // Avatar
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        dashPattern: const [6, 3],
                        color: Colors.grey,
                        strokeWidth: 1.5,
                        child: Container(
                          height: size.height * 0.13,
                          width: size.height * 0.13,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE7E7E7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 2,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: imagePath != null
                                ? Image.asset(
                                    imagePath!,
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.add_outlined,
                                      size: size.height * 0.04,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),

                    // Add New Account
                    Text(
                      'Add Account',
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins-normal',
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            // Display Info
            Column(
              children: [
                const BoxDetail(
                  title: 'DICE created',
                  value: '0',
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                Divider(
                    height: size.height * 0.01,
                    thickness: size.height * 0.002,
                    color: Colors.black26),
                const BoxDetail(
                  title: 'DICE hosted',
                  value: '0',
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
              ],
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            // Display Info
            Column(
              children: [
                const BoxDetail(
                  title: 'Assigned DICE played',
                  value: '0',
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                Divider(
                    height: size.height * 0.01,
                    thickness: size.height * 0.002,
                    color: Colors.black26),
                const BoxDetail(
                  title: 'Live DICE played',
                  value: '0',
                ),
                Divider(
                    height: size.height * 0.01,
                    thickness: size.height * 0.002,
                    color: Colors.black26),
                const BoxDetail(
                  title: 'Total games played',
                  value: '0',
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
