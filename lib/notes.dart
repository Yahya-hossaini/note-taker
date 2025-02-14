import 'package:flutter/material.dart';

class Notes with ChangeNotifier {
  final String id;
  final String title;
  final String content;

  Notes({
    required this.id,
    required this.title,
    required this.content,
  });
}
