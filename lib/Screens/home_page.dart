import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2939),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 60),
        child: const CustomAppbar(
          rightSideSelector: 'image',
          leftSideSelector: 'back',
        ),
      ),
    );
  }
}
