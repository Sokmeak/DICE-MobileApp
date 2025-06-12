import 'package:flutter/material.dart';
import 'package:product_dice/core/data/user_type_data.dart';
import 'package:product_dice/features/setting/widgets/app_bar_setting.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String selectedUserType = UserTypeData.student;

  final List<String> userTypes = [
    UserTypeData.student,
    UserTypeData.teacher,
    UserTypeData.organization,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarSetting(title: 'Select User Type'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.02,
        ),
        child: Column(
          children: userTypes.map((type) {
            final isSelected = selectedUserType == type;

            return Container(
              margin: EdgeInsets.only(bottom: size.height * 0.015),
              decoration: BoxDecoration(
                color: const Color(0xFFE7E7E7),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  isSelected ? type : type,
                  style: const TextStyle(
                    fontFamily: 'poppins-normal',
                    fontSize: 16,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: Colors.black,
                        size: size.height * 0.03,
                      )
                    : const SizedBox.shrink(),
                onTap: () {
                  setState(() {
                    selectedUserType = type;
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
