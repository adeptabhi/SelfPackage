// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/scr/util/styles.dart';
import 'package:selfpackage/scr/util/widget.dart';
import 'package:selfpackage/scr/util/widget_class/vy_textfield.dart';

class _DataTableTheme {
  final Color borderColor = const Color(0xFFE1DEDE);
  final Color headerBgColor = Colors.blue.shade50;
  final double borderWidth = 1;
  final TextStyle headingTextStyle = stylesWorkSans(
      fontSize: 10.5,
      color: const Color(0xFF1D4380),
      fontWeight: FontWeight.w600);
  final TextStyle cellTextStyle = stylesWorkSans(
      fontSize: 12, color: Colors.grey.shade800, fontWeight: FontWeight.w600);
}

class VyDataTableMdl {
  String? headName;
  List<String> columnNames;
  List<DataRow> dataRowsList;
  VyDataTableMdl(
      {this.headName, required this.columnNames, required this.dataRowsList});
}

class VyDataTable extends StatefulWidget {
  String head;
  final void Function(String) onSearch;
  final List<VyDataTableMdl> dataTableMdlList;
  late int pagerLength = 0;
  VyDataTable(
      {super.key,
      this.head = '',
      required this.onSearch,
      required this.dataTableMdlList}) {
    pagerLength = dataTableMdlList.isEmpty
        ? 0
        : (dataTableMdlList[0].dataRowsList.length / 10).ceil();
  }
  @override
  State<VyDataTable> createState() => _VyDataTableState();
}

class _VyDataTableState extends State<VyDataTable> {
  _DataTableTheme theme = _DataTableTheme();
  TextEditingController txtCon = TextEditingController();
  int slctIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.head.isNotEmpty)
          Text(widget.head,
              style: stylesWorkSans(color: Colors.blue.shade800, fontSize: 16)),
        VyTextField(
            txtCon: txtCon,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            onChanged: widget.onSearch,
            hintText: 'Search'),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  widget.dataTableMdlList.length,
                  (i) => IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (widget.dataTableMdlList[i].headName != null)
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: theme.headerBgColor,
                                    border: Border(
                                        left: BorderSide(
                                            color: theme.borderColor,
                                            width: 0.5),
                                        top: BorderSide(
                                            color: theme.borderColor,
                                            width: 0.8),
                                        right: BorderSide(
                                            color: theme.borderColor,
                                            width: 0.8))),
                                alignment: Alignment.center,
                                child: Text(
                                    widget.dataTableMdlList[i].headName!,
                                    style: theme.headingTextStyle),
                              ),
                            SizedBox(
                              width: double.infinity,
                              child: _DataTableHelper(
                                  hasNoHeaderAndSibling:
                                      widget.dataTableMdlList[i].headName ==
                                              null &&
                                          widget.dataTableMdlList.length > 1,
                                  columnNames:
                                      widget.dataTableMdlList[i].columnNames,
                                  dataRows: getList(i),
                                  theme: theme),
                            ),
                          ],
                        ),
                      )),
            )),
        if (widget.pagerLength != 0) dataTablePager(),
      ],
    );
  }

  Widget dataTablePager() {
    return SizedBox(
        height: 55,
        child: Row(
          children: [
            Text('Total - ${widget.pagerLength}',
                style: stylesWorkSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: const Color(0xFF1C212D))),
            const SizedBox(width: 5),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  arrowLeftRight(true),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                                widget.pagerLength,
                                (i) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          slctIndex = i;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: slctIndex == i
                                                ? Colors.blue.shade800
                                                : Colors.white),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${i + 1}',
                                          style: stylesWorkSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: slctIndex != i
                                                  ? const Color(0xFF1C212D)
                                                  : Colors.white),
                                        ),
                                      ),
                                    )),
                          ]),
                    ),
                  ),
                  arrowLeftRight(false),
                ],
              ),
            ),
          ],
        ));
  }

  Widget arrowLeftRight(bool isLeft) {
    return InkWell(
        onTap: () => onTapArrow(isLeft),
        child: Padding(
            padding:
                EdgeInsets.only(right: isLeft ? 15 : 0, left: isLeft ? 0 : 15),
            child: Icon(
                size: 16,
                isLeft ? Icons.arrow_back_ios : Icons.arrow_forward_ios)));
  }

  void onTapArrow(bool isLeft) {
    if (isLeft && slctIndex != 0) {
      setState(() {
        slctIndex -= 1;
      });
    }
    if (!isLeft && slctIndex < (widget.pagerLength - 1)) {
      setState(() {
        slctIndex += 1;
      });
    }
  }

  List<DataRow> getList(int i, {int pageSize = 10}) {
    int startIndex = slctIndex * pageSize;
    int endIndex = startIndex + pageSize;
    if (endIndex > widget.dataTableMdlList[i].dataRowsList.length) {
      endIndex = widget.dataTableMdlList[i].dataRowsList.length;
    }
    if (startIndex < widget.dataTableMdlList[i].dataRowsList.length) {
      return widget.dataTableMdlList[i].dataRowsList
          .sublist(startIndex, endIndex);
    } else {
      return [];
    }
  }
}

class _DataTableHelper extends StatelessWidget {
  final bool hasNoHeaderAndSibling;
  final List<String> columnNames;
  final List<DataRow> dataRows;
  final _DataTableTheme theme;
  const _DataTableHelper(
      {required this.columnNames,
      required this.dataRows,
      required this.hasNoHeaderAndSibling,
      required this.theme});
  @override
  Widget build(BuildContext context) {
    return DataTableTheme(
      data: DataTableThemeData(
          horizontalMargin: 0,
          // headingRowAlignment: MainAxisAlignment.center,
          checkboxHorizontalMargin: 0,
          columnSpacing: 0,
          dataRowMaxHeight: 40,
          dataRowMinHeight: 35,
          headingRowHeight: hasNoHeaderAndSibling ? 73 : 45,
          headingRowColor: WidgetStateProperty.all(theme.headerBgColor),
          decoration: BoxDecoration(
              border: Border.all(color: theme.borderColor, width: 0.5))),
      child: DataTable(
        border: TableBorder.all(color: theme.borderColor, width: 0.5),
        columns: <DataColumn>[
          ...List.generate(
              columnNames.length, (i) => dataTableColum(columnNames[i]))
        ],
        rows: dataRows,
      ),
    );
  }

  DataColumn dataTableColum(String name) {
    return DataColumn(
        label: Expanded(
            child: Container(
                color: theme.headerBgColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Text(name,
                          overflow: TextOverflow.ellipsis,
                          style: theme.headingTextStyle),
                    ),
                  ],
                ))));
  }
}

class VyDataTableCell {
  final String value;
  final double? width;
  final Color? color;
  final bool isBold;
  final VoidCallback? callback;

  VyDataTableCell({
    required this.value,
    this.width,
    this.color,
    this.isBold = false,
    this.callback,
  });

  _DataTableTheme theme = _DataTableTheme();

  DataCell toCell() {
    return DataCell(
      onTap: callback,
      Container(
        color: color,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        alignment: Alignment.center,
        child: Text(value,
            style: theme.cellTextStyle.copyWith(
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
      ),
    );
  }
}

class DataTableUiFix extends StatelessWidget {
  final double columnWidth;
  final VyDataTableMdl dataTableMdl;
  final _DataTableTheme _theme = _DataTableTheme();
  DataTableUiFix(
      {super.key, required this.columnWidth, required this.dataTableMdl});
  @override
  Widget build(BuildContext context) {
    return DataTableTheme(
      data:
          const DataTableThemeData(dataRowMinHeight: 40, dataRowMaxHeight: 40),
      child: DataTable(
          border: TableBorder.all(
              color: _theme.borderColor, width: _theme.borderWidth),
          horizontalMargin: 0,
          columnSpacing: 0,
          dividerThickness: 1,
          showBottomBorder: false,
          headingRowColor: WidgetStateProperty.all(_theme.headerBgColor),
          headingRowHeight: 40,
          columns: getListColumn(),
          rows: dataTableMdl.dataRowsList),
    );
  }

  List<DataColumn> getListColumn() {
    return List.generate(
        dataTableMdl.columnNames.length,
        (i) => DataColumn(
              label: SizedBox(
                width: columnWidth,
                child: Text(dataTableMdl.columnNames[i],
                    textAlign: TextAlign.center,
                    style: stylesWorkSans(
                        fontSize: 10.5,
                        color: const Color(0xFF1D4380),
                        fontWeight: FontWeight.w600)),
              ),
            ));
  }
}
