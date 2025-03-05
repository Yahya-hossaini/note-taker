import 'dart:ui';

import 'package:flutter/material.dart';

const Color kScaffoldColor = Color(0xFF1E2939);
const Color kButtonColor = Color(0xFF54F34F);
const Color kCardColor = Color(0xFF404040);
const Color kPrimaryColor = Color(0xFFD4D4D8);
const Color kSignInUpScaffoldColor = Color(0xFF0F172B);
const Color kTextFieldColor = Color(0xFF2C2C2C);

/////////////////////////////Text styles
//card note text style
TextStyle kNoteCardTextStyle = const TextStyle(
  fontSize: 16,
  color: kPrimaryColor,
);

//Note counter text style
TextStyle kNoteCounterTextStyle = const TextStyle(
  fontSize: 48,
  color: kButtonColor,
);

//Note counter title text style
TextStyle kNoteCounterTitleTextStyle =
    const TextStyle(fontSize: 20, color: kPrimaryColor);

// for login and sign up page names
TextStyle kPageNameTextStyle = const TextStyle(
  color: Colors.white70,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

//for input warnings
TextStyle kInputWarningTextStyle = const TextStyle(
  color: Colors.red,
  fontSize: 14,
);

TextStyle kLoginSignupNavigatorTextStyle = const TextStyle(
  color: Color(0xFFD4D4D8),
  fontSize: 16,
  decoration: TextDecoration.underline,
  decorationColor: Color(0xFFD4D4D8),
);

TextStyle kNoteTitleTextStyle = const TextStyle(
  color: Colors.white38,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

///////////////////////////////////Widget styles
ButtonStyle? kLoginSignupButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kButtonColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

InputDecoration? kNoteTitleInputDecoration = const InputDecoration(
    hintText: 'Title',
    hintStyle: TextStyle(
      color: Colors.white38,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    border: InputBorder.none,
);

InputDecoration? kTextAreaInputDecoration = const InputDecoration(
  hintText: 'Write your note here....',
  hintStyle: TextStyle(color: Colors.white38),
  border: InputBorder.none,
);
