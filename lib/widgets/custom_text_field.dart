import 'package:flutter/material.dart';
import 'package:my_notes/styles.dart';

//Custom Text field

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: controller,
      style: const TextStyle(color: Colors.white70, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: kTextFieldColor, // Zinc-800 equivalent
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white38,
        ), // Zinc-400 equivalent
        labelText: title,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ), // Zinc-400 equivalent
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
