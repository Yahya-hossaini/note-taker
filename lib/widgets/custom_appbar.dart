import 'package:flutter/material.dart';
import 'package:supabase_project/styles.dart';

class CustomAppbar extends StatelessWidget {
  final String rightSideSelector;
  final String leftSideSelector;

  const CustomAppbar({
    super.key,
    required this.rightSideSelector,
    required this.leftSideSelector,
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
            leftSideSelector == 'menu' ? IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: kPrimaryColor,
              ),
              iconSize: 32,
            ) : IconButton(
              onPressed: () {},
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
            rightSideSelector == 'save'
                ? IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.save,
                color: kPrimaryColor,
              ),
              iconSize: 32,
            )
                : Image.asset(
              'assets/images/Logo.png',
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