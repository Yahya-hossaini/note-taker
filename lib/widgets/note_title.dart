import 'package:flutter/material.dart';

import '../styles.dart';

class NoteTitle extends StatelessWidget {
  const NoteTitle({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      style: const TextStyle(
        color: kPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none),
    );
  }
}