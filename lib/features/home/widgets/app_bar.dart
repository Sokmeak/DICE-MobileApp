import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final ImageProvider? imageLogo;
  final ImageProvider? imageUser;
  final IconData iconAction;
  final VoidCallback? onAvatarTap;

  const AppBarCustom({
    super.key,
    this.imageLogo,
    this.imageUser,
    required this.iconAction,
    this.onAvatarTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      child: SafeArea(
        child: Container(
          height: preferredSize.height,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              imageLogo != null
                  ? Image(
                      image: imageLogo!,
                      height: size.height * 0.05,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox.shrink(),

              // Action Icon and Avatar
              Row(
                children: [
                  IconButton(
                    icon: Icon(iconAction, size: size.height * 0.03),
                    onPressed: () {
                      // Handle action icon press
                    },
                  ),
                  GestureDetector(
                    onTap: onAvatarTap,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: imageUser,
                        radius: size.height * 0.022,
                        child: imageUser == null
                            ? const Icon(Icons.person,
                                color: Colors.grey, size: 18)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
