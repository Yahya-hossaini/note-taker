import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome❤'),
      ),
    );
  }
}
