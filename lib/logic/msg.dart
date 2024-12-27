import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// toastMsg(String value) {
//   Fluttertoast.cancel();
//   Fluttertoast.showToast(
//     msg: value,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     //  backgroundColor: Colors.green,
//     textColor: Colors.white,
//     fontSize: 12.0,
//   );
// }

// toastMsgCancel() {
//   Fluttertoast.cancel();
// }

snackBarMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.grey,
  ));
}

void logError(String name, {required var msg}) {
  log('\x1B[31m$msg\x1B[0m', name: '\x1B[37m$name\x1B[0m');
}

void logInfo(String name, {required var msg}) {
  log('\x1B[33m$msg\x1B[0m', name: '\x1B[37m$name\x1B[0m');
}

void logSuccess(String name, {required var msg}) {
  log('\x1B[32m$msg\x1B[0m', name: '\x1B[37m$name\x1B[0m');
}
