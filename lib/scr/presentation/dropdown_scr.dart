// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:selfpackage/bloc/dropdown_bloc.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/widget.dart';
import 'package:selfpackage/scr/util/widget_class/Vy_textfield.dart';
import 'package:selfpackage/scr/util/widget_class/vy_dropdown.dart';

class DropDownScr extends StatefulWidget {
  const DropDownScr({super.key});
  @override
  _DropDownScrState createState() => _DropDownScrState();
}

class _DropDownScrState extends State<DropDownScr> {
  late DropdownBloc bloc = DropdownBloc(context: context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wuAppBar(title: 'DropDown'),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            VyDropDown<IdNameMdl>(
                head: 'DropDown',
                valueNotifier: bloc.dropdown1,
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyMultiDropDown<IdNameVisibleMdl>(
                head: 'Multi DropDown',
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyDropDown<IdNameMdl>(
                head: 'DropDown',
                valueNotifier: bloc.dropdown2,
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyMultiDropDown<IdNameVisibleMdl>(
                head: 'Multi DropDown',
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyDropDown<IdNameMdl>(
                head: 'DropDown',
                valueNotifier: bloc.dropdown3,
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyMultiDropDown<IdNameVisibleMdl>(
                head: 'Multi DropDown',
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyDropDown<IdNameMdl>(
                head: 'DropDown',
                valueNotifier: bloc.dropdown4,
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyMultiDropDown<IdNameVisibleMdl>(
                head: 'Multi DropDown',
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
            const SizedBox(height: 10),
            VyDropDown<IdNameMdl>(
                head: 'DropDown',
                valueNotifier: bloc.dropdown5,
                getList: bloc.getList,
                getText: (mdl) => mdl.name),
          ]),
        ));
  }
}
