import 'package:flutter/material.dart';
import 'package:selfpackage/scr/util/styles.dart';

InputDecoration txtInputDecoration() {
  return InputDecoration(
      hintStyle: stylesWorkSans(
          fontSize: 16,
          color: const Color(0xFF808080).withOpacity(0.35),
          fontWeight: FontWeight.w500),
      labelStyle: const TextStyle(color: Color.fromARGB(114, 0, 0, 0)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Color(0xFFC7C7CC), width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Color(0xFFC7C7CC), width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Color(0xFFC7C7CC), width: 1)));
}
