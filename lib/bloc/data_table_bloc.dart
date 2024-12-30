import 'package:flutter/material.dart';
import 'package:selfpackage/model/data_table_mdl.dart';

class DataTableBloc {
  BuildContext context;
  DataTableBloc({required this.context});
  final List<DataTableMdl> list = List.generate(
      26,
      (i) => DataTableMdl(
          id: '${i + 1}',
          name: 'Item ${String.fromCharCodes([i + 65])}',
          description: 'Description for Item ${String.fromCharCodes([i + 65])}',
          status: 'Inactive',
          amount: 200.0,
          date: DateTime.now().subtract(const Duration(days: 1))));
  late ValueNotifier<List<DataTableMdl>> notifierList1 = ValueNotifier(list);
  late ValueNotifier<List<DataTableMdl>> notifierList2 = ValueNotifier(list);

  void onSearch(String txt, isFirst) {
    var data =
        list.where((e) => e.toAdd().contains(txt.toLowerCase())).toList();
    if (isFirst) {
      notifierList1.value = data;
    } else {
      notifierList2.value = data;
    }
  }
}
