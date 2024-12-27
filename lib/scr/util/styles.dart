import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle stylesWorkSans(
    {double fontSize = 15,
    Color color = const Color(0xFF808080),
    FontWeight fontWeight = FontWeight.w500}) {
  return GoogleFonts.workSans(
      fontSize: fontSize, color: color, fontWeight: fontWeight);
}
