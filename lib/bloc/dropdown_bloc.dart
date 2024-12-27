import 'package:flutter/material.dart';
import 'package:selfpackage/model/util_mdl.dart';

class DropdownBloc {
  final BuildContext context;
  DropdownBloc({required this.context});
  ValueNotifier<IdNameMdl?> dropdown1 = ValueNotifier(null);
  ValueNotifier<IdNameMdl?> dropdown2 = ValueNotifier(null);
  ValueNotifier<IdNameMdl?> dropdown3 = ValueNotifier(null);
  ValueNotifier<IdNameMdl?> dropdown4 = ValueNotifier(null);
  ValueNotifier<IdNameMdl?> dropdown5 = ValueNotifier(null);

  List getList(String check) {
    switch (check) {
      case 'DropDown':
        return List.generate(
            10, (index) => IdNameMdl(id: 0, name: 'Vikas ${index + 1}'));
      case 'Multi DropDown':
        return List.generate(
            11,
            (index) => IdNameVisibleMdl(
                id: 0, name: 'Vikas ${index + 1}', isVisible: false));
      default:
        return [];
    }
  }
}
