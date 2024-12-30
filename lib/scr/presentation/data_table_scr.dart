// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:selfpackage/bloc/data_table_bloc.dart';
import 'package:selfpackage/bloc/dropdown_bloc.dart';
import 'package:selfpackage/bloc/textfield_bloc.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/model/data_table_mdl.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/widget.dart';
import 'package:selfpackage/scr/util/widget_class/vy_data_table.dart';
import 'package:selfpackage/scr/util/widget_class/vy_dropdown.dart';
import 'package:selfpackage/scr/util/widget_class/vy_textfield.dart';

class DataTableScr extends StatefulWidget {
  const DataTableScr({super.key});
  @override
  _DataTableScrState createState() => _DataTableScrState();
}

class _DataTableScrState extends State<DataTableScr> {
  late DataTableBloc bloc = DataTableBloc(context: context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wuAppBar(title: 'DataTable'),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            ValueListenableBuilder<List<DataTableMdl>>(
                valueListenable: bloc.notifierList1,
                builder: (context, list, widget) {
                  return VyDataTable(
                      head: '1. Vikas Data Table with Single Header Ui',
                      onSearch: (dd) => bloc.onSearch(dd, true),
                      dataTableMdlList:
                          _DataTableRow1(context: context, list: list)
                              .toList());
                }),
            ValueListenableBuilder<List<DataTableMdl>>(
                valueListenable: bloc.notifierList2,
                builder: (context, list, widget) {
                  return VyDataTable(
                      head: '2. Vikas Data Table with Multi Header Ui',
                      onSearch: (dd) => bloc.onSearch(dd, false),
                      dataTableMdlList:
                          _DataTableRow2(context: context, list: list)
                              .toList());
                }),
            DataTableUiFix(
                columnWidth: 50,
                dataTableMdl: _DataTableRow1(context: context, list: bloc.list)
                    .toList()[0])
          ]),
        ));
  }
}

class _DataTableRow1 {
  BuildContext context;
  List<DataTableMdl> list;
  _DataTableRow1({required this.context, required this.list});
  VyDataTableMdl dataTableMdl = VyDataTableMdl(
      columnNames: ['Id', 'Name', 'Description', 'Status', 'Date'],
      dataRowsList: []);
  List<VyDataTableMdl> toList() {
    for (DataTableMdl mdl in list) {
      dataTableMdl.dataRowsList.add(DataRow(cells: [
        VyDataTableCell(value: mdl.id).toCell(),
        VyDataTableCell(value: mdl.name).toCell(),
        VyDataTableCell(value: mdl.description).toCell(),
        VyDataTableCell(value: mdl.status).toCell(),
        VyDataTableCell(value: mdl.date.toString()).toCell(),
      ]));
    }
    return [dataTableMdl];
  }
}

class _DataTableRow2 {
  BuildContext context;
  List<DataTableMdl> list;
  _DataTableRow2({required this.context, required this.list});

  VyDataTableMdl dataTableMdl1 =
      VyDataTableMdl(columnNames: ['Id', 'Name'], dataRowsList: []);
  VyDataTableMdl dataTableMdl2 = VyDataTableMdl(
      headName: "Info", columnNames: ['Description', 'Date'], dataRowsList: []);
  VyDataTableMdl dataTableMdl3 =
      VyDataTableMdl(columnNames: ['Status'], dataRowsList: []);

  List<VyDataTableMdl> toList() {
    for (DataTableMdl mdl in list) {
      dataTableMdl1.dataRowsList.add(DataRow(cells: [
        VyDataTableCell(value: mdl.id).toCell(),
        VyDataTableCell(value: mdl.name).toCell(),
      ]));

      dataTableMdl2.dataRowsList.add(DataRow(cells: [
        VyDataTableCell(value: mdl.description).toCell(),
        VyDataTableCell(value: mdl.date.toString()).toCell(),
      ]));
      dataTableMdl3.dataRowsList.add(DataRow(cells: [
        VyDataTableCell(value: mdl.status).toCell(),
      ]));
    }
    return [dataTableMdl1, dataTableMdl2, dataTableMdl3];
  }
}
