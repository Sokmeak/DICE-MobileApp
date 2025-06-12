import 'package:flutter/material.dart';
import 'package:product_dice/core/widgets/button_custom.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  String? imagePath;
  String? selectedReason;

  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(title: 'Delete Account'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Delete Account
              Text(
                'Are you sure you’d like to delete your account?',
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w500,
                ),
              ),

              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Avatar
                          Container(
                            height: size.height * 0.08,
                            width: size.height * 0.08,
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
                                          fontSize: size.height * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.02,
                          ),

                          // Username
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      // Drop Down
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reason for deleting account',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Center(
                            child: Container(
                              width: size.width * 0.9,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                                vertical: size.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200]!,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 2),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                value: selectedReason,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                hint: Text(
                                  'Select reason',
                                  style: TextStyle(
                                    fontFamily: 'poppins-normal',
                                    fontSize: size.height * 0.018,
                                  ),
                                ),
                                items: [
                                  'Privacy concerns',
                                  'Too many notifications',
                                  'Creating a new account',
                                  'Not satisfied with the app',
                                  'Other',
                                ].map((reason) {
                                  return DropdownMenuItem<String>(
                                    value: reason,
                                    child: Text(
                                      reason,
                                      style: TextStyle(
                                        fontFamily: 'poppins-normal',
                                        fontSize: size.height * 0.018,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedReason = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      // Reason
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reason for deleting account',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins-normal',
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextField(
                            maxLines: 5,
                            controller: _reasonController,
                            decoration: InputDecoration(
                              hintText: 'Add your feedback here...',
                              hintStyle: TextStyle(
                                fontFamily: 'poppins-normal',
                                fontSize: size.height * 0.018,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      Row(
                        children: [
                          Expanded(
                            child: ButtonCustom(
                              textColor: Colors.black,
                              text: 'Cancel',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.grey[400]!,
                              borderRadius: 10,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: ButtonCustom(
                              text: 'Delete Account',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap a button
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      title: const Text(
                                        'Confirm Deletion',
                                        style: TextStyle(
                                          fontFamily: 'poppins-semibold',
                                        ),
                                      ),
                                      content: const Text(
                                        'Are you sure you want to delete your account? This action cannot be undone.',
                                        style: TextStyle(
                                          fontFamily: 'poppins-normal',
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // dismiss dialog
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'poppins-medium',
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.redAccent[700],
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                '/signin'); // close dialog
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              fontFamily: 'poppins-semibold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              color: Colors.redAccent[700]!,
                              borderRadius: 10,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
