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
      elevation: 0, // flat look, no shadow
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      flexibleSpace: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 8,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87,
                  size: size.height * 0.025,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontFamily: 'poppins-normal',
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
