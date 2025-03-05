import 'package:flutter/material.dart';
import 'package:my_notes/styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.title,
    required this.controller,
    required this.obscureText,
    this.onChanged,
    required this.keyboardType,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isObscured,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: Colors.white70, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: kTextFieldColor, // Zinc-800 equivalent
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.white38,
        ), // Zinc-400 equivalent
        labelText: widget.title,
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
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
            color: Colors.white38,
          ),
          onPressed: _toggleObscureText,
        )
            : null,
      ),
    );
  }
}
