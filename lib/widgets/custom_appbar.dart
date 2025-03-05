import 'package:flutter/material.dart';
import 'package:my_notes/styles.dart';

import '../auth_service.dart';

class CustomAppbar extends StatelessWidget {
  final String leftSideSelector;
  final VoidCallback? onBackPressed;

  const CustomAppbar({
    super.key,
    required this.leftSideSelector,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(18),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leftSideSelector == 'logout') Transform.rotate(
              angle: 180 * 3.1415926535897932 / 180,
              child: IconButton(
                onPressed: () async {
                  await AuthService().signOut();
                } ,
                icon: const Icon(
                  Icons.logout,
                  color: kPrimaryColor,
                ),
                iconSize: 32,
              ),
            ) else IconButton(
              onPressed: onBackPressed ?? () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: kPrimaryColor,
              ),
              iconSize: 32,
            ),
            const Text(
              'My Notes',
              style: TextStyle(
                color: kPrimaryColor,
              ),
            ),
            Image.asset(
              'assets/images/Logo-app.png',
              height: 48,
              width: 48,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: kSignInUpScaffoldColor,
      ),
    );
  }
}