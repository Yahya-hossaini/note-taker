import 'package:flutter/material.dart';

class Notes with ChangeNotifier {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  Notes(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt});

  // Converting to JSON(for saving in database)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  //converting from JSON(when retrieving from database)
  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
    );
  }
}
