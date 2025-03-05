import 'package:flutter/material.dart';

import '../styles.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    required TextEditingController contentController,
  }) : _contentController = contentController;

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _contentController,
        style: const TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          hintText: 'Write your note here....',
          hintStyle: TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }
}