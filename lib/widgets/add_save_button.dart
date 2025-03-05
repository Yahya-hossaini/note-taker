import 'package:flutter/material.dart';

import '../styles.dart';

class AddSaveButton extends StatelessWidget {
  final String title;

  const AddSaveButton({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 124,
      decoration: BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}