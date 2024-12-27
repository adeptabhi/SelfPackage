import 'package:flutter/material.dart';
import 'package:selfpackage/scr/util/styles.dart';

AppBar wuAppBar({required String title}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: Colors.blue.shade600,
    title: Text(title, style: const TextStyle(color: Colors.white)),
  );
}

Widget wuHead(bool isRequired, String text) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(children: [
        if (isRequired) const Text('* ', style: TextStyle(color: Colors.red)),
        Text(text,
            style: stylesWorkSans(color: const Color(0xFF848482), fontSize: 14))
      ]));
}
