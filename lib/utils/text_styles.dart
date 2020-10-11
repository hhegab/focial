import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryTextStyles {
  final style = 10;
  static final styles = [_roboto, _ruluko, _comforta, _merriweather, _lobster, _patrikHand];
  static const fontSize = 28.0;

  static final TextStyle _roboto = TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  static final TextStyle _ruluko = TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.ruluko().fontFamily,
  );

  static final TextStyle _comforta = TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
  );

  static final TextStyle _merriweather = TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.merriweather().fontFamily,
  );

  static final TextStyle _lobster = TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.lobster().fontFamily,
  );

  static final TextStyle _patrikHand = TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.patrickHand().fontFamily,
  );
}
