// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:selfpackage/bloc/dropdown_bloc.dart';
import 'package:selfpackage/bloc/textfield_bloc.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/widget.dart';
import 'package:selfpackage/scr/util/widget_class/vikas_dropdown.dart';
import 'package:selfpackage/scr/util/widget_class/vikas_textfield.dart';

class TextFieldScr extends StatefulWidget {
  const TextFieldScr({super.key});
  @override
  _TextFieldScrState createState() => _TextFieldScrState();
}

class _TextFieldScrState extends State<TextFieldScr> {
  late TextFieldBloc bloc = TextFieldBloc(context: context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wuAppBar(title: 'TextField'),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            VikasTextAutoComplete<IdNameMdl>(
                head: 'Auto Complete',
                hintText: 'Please Enter',
                txtCon: bloc.txtCon6,
                getList: bloc.getList,
                getText: (mdl) => mdl.name,
                onChanged: (IdNameMdl? mdl) {}),
            const SizedBox(height: 10),
            VikasTextField(
                head: 'Enter Your Name',
                txtCon: bloc.txtCon1,
                hintText: 'Enter Your Name'),
            const SizedBox(height: 10),
            VikasTextField(
                head: 'Enter Your Number',
                txtCon: bloc.txtCon2,
                isNumber: true,
                maxLen: 10,
                hintText: 'Enter Your Number'),
            const SizedBox(height: 10),
            VikasTextField(
                head: 'Enter Your Password',
                txtCon: bloc.txtCon3,
                isHideText: true,
                hintText: 'Enter Your Password'),
            const SizedBox(height: 10),
            VikasTextField(
                head: 'Disable',
                txtCon: bloc.txtCon4,
                isEnable: false,
                hintText: 'Disable'),
            const SizedBox(height: 10),
            VikasTextAutoComplete<IdNameMdl>(
                head: 'Auto Complete',
                hintText: 'Please Enter',
                txtCon: bloc.txtCon5,
                getList: bloc.getList,
                getText: (mdl) => mdl.name,
                onChanged: (IdNameMdl? mdl) {
                  logError('name', msg: mdl == null);
                }),
            const SizedBox(height: 10),
          ]),
        ));
  }
}
