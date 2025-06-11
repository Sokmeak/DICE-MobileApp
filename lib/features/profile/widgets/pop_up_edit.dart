import 'package:flutter/material.dart';
import 'package:product_dice/core/theme/colors.dart';
import 'package:product_dice/core/widgets/button_custom.dart';
import 'package:product_dice/core/widgets/text_field_custom.dart';
import 'package:product_dice/features/profile/widgets/categories_edit.dart';

class PopUpEdit extends StatefulWidget {
  const PopUpEdit({super.key});

  @override
  State<PopUpEdit> createState() => _PopUpEditState();
}

class _PopUpEditState extends State<PopUpEdit> {
  String? imagePath;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            'Complete Your Profile',
            style: TextStyle(
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins-normal',
            ),
          ),

          SizedBox(height: size.height * 0.02),

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

          SizedBox(height: size.height * 0.02),

          Text(
            'Your profile you can upload by any ways below',
            style: TextStyle(
              fontSize: size.height * 0.015,
              fontWeight: FontWeight.normal,
              fontFamily: 'poppins-normal',
            ),
          ),

          Row(
            children: [
              Expanded(
                child: CategoriesEdit(
                  title: 'Character',
                  icon: Icons.person_outline_rounded,
                  onTap: () {},
                ),
              ),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: CategoriesEdit(
                  title: 'Image',
                  icon: Icons.image_outlined,
                  onTap: () {},
                ),
              ),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: CategoriesEdit(
                  title: 'Avatar',
                  icon: Icons.camera_alt_outlined,
                  onTap: () {},
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.03),

          //TextField name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add your name',
                style: TextStyle(
                  fontSize: size.height * 0.015,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFieldCustom(
                hintText: 'Name',
                controller: _nameController,
                label: 'Name',
              ),
            ],
          ),

          // TextField username
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  fontSize: size.height * 0.015,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFieldCustom(
                hintText: 'Username',
                controller: _usernameController,
                label: 'Username',
              ),
            ],
          ),

          SizedBox(height: size.height * 0.03),

          // Button Save and Cancel
          Row(
            children: [
              Expanded(
                child: ButtonCustom(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.grey,
                  borderRadius: 10,
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: ButtonCustom(
                  text: 'Save',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.greenAccent[400]!,
                  borderRadius: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
