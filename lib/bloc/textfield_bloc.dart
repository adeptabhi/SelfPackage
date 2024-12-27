import 'package:flutter/material.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/model/util_mdl.dart';

class TextFieldBloc {
  final BuildContext context;
  TextFieldBloc({required this.context});
  TextEditingController txtCon1 = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();
  TextEditingController txtCon3 = TextEditingController();
  TextEditingController txtCon4 = TextEditingController();
  TextEditingController txtCon5 = TextEditingController();
  TextEditingController txtCon6 = TextEditingController();
  List getList(String check) {
    switch (check) {
      case 'Auto Complete':
        return List.generate(
            20, (index) => IdNameMdl(id: 0, name: 'Vikas ${index + 1}'));
      default:
        return [];
    }
  }
}
