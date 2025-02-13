import 'package:flutter/material.dart';

//Custom Text field

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  const CustomTextField({
    super.key, required this.hintText, required this.title, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: controller,
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF2C2C2C), // Zinc-800 equivalent
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFD4D4D8),
        ), // Zinc-400 equivalent
        labelText: title,
        labelStyle: const TextStyle(
          color: Color(0xFF7C7C7C),
        ), // Zinc-400 equivalent
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}