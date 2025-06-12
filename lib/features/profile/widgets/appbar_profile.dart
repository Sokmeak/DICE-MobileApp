import 'package:flutter/material.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onEditTap;
  final VoidCallback? onSettingTap;
  const AppBarProfile(
      {super.key, this.onEditTap, this.onSettingTap, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppBar(
      leading: Container(
        margin: EdgeInsets.only(left: size.width * 0.02),
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
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: size.height * 0.02,
        ),
      ),
      title: Text(title ?? ''),
      actions: [
        Container(
          margin: EdgeInsets.only(right: size.width * 0.02),
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
          child: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEditTap,
            iconSize: size.height * 0.02,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: size.width * 0.02),
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
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: onSettingTap,
            iconSize: size.height * 0.02,
          ),
        ),
      ],
    );
  }
}
