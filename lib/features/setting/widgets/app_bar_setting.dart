import 'package:flutter/material.dart';

class AppBarSetting extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarSetting({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: const Color(0xFFE7E7E7),
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: size.height * 0.02,
        ),
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: size.height * 0.025,
            fontFamily: 'poppins-normal',
          ),
        ),
      ),
    );
  }
}
