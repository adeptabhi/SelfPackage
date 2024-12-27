// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/scr/util/styles.dart';
import 'package:selfpackage/scr/util/widget.dart';

enum _Position { top, bottom, center }

class VikasDropDown<T> extends StatelessWidget {
  final String head;
  final ValueNotifier<T?> valueNotifier;
  final List Function(String) getList;
  final String Function(T) getText;
  final bool isSearch;
  final bool isRequired;
  final Function(T)? onChanged;
  final bool Function(T)? canSlct;
  late EdgeInsets padding;
  VikasDropDown(
      {super.key,
      required this.head,
      required this.valueNotifier,
      required this.getList,
      required this.getText,
      this.isSearch = true,
      this.isRequired = true,
      this.canSlct,
      this.onChanged,
      EdgeInsets? padding}) {
    this.padding =
        padding ?? const EdgeInsets.only(left: 10, right: 10, top: 10);
  }
  late final _Helper<T> _helper = _Helper<T>(
      head: head,
      getList: getList,
      getText: getText,
      isSearch: isSearch,
      isMutliSelection: false);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (head.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: wuHead(isRequired, head)),
            InkWell(
              onTap: () async {
                dynamic value = await _helper.onTap(context);
                if (value != null) {
                  value as T;
                  if (canSlct == null || canSlct!(value)) {
                    valueNotifier.value = value;
                    if (onChanged != null) onChanged!(value);
                  }
                }
              },
              child: _helper.container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    ValueListenableBuilder<T?>(
                        valueListenable: valueNotifier,
                        builder: (context, mdl, dd) {
                          return Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                  mdl == null ? 'Select $head' : getText(mdl),
                                  style: stylesWorkSans(
                                      fontSize: 16,
                                      color: const Color(0xFF808080)
                                          .withOpacity(mdl == null ? 0.35 : 1),
                                      fontWeight: mdl == null
                                          ? FontWeight.w500
                                          : FontWeight.w400)),
                            ),
                          );
                        }),
                    _helper.arrow(),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}

/*IN T Model isVisible variable is required*/
class VikasMultiDropDown<T> extends StatelessWidget {
  final String head;
  final List Function(String) getList;
  final String Function(T) getText;
  final bool isSearch;
  final bool isRequired;
  final bool isOpen;
  final Function(String)? onChanged;
  final EdgeInsets? padding;

  VikasMultiDropDown(
      {required this.head,
      required this.getList,
      required this.getText,
      this.isRequired = true,
      this.isSearch = true,
      this.isOpen = false,
      this.onChanged,
      this.padding,
      super.key});
  late final _Helper<T> _helper = _Helper<T>(
      head: head,
      getList: getList,
      getText: getText,
      isSearch: isSearch,
      isMutliSelection: true);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wuHead(true, head),
          StatefulBuilder(builder: (context, setState) {
            return InkWell(
              onTap: () async {
                await _helper.onTap(context);
                setState(() {});
                if (onChanged != null) onChanged!(head);
              },
              child: _helper.container(
                  child: StatefulBuilder(builder: (context, setState) {
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: splitList(
                              setState: setState,
                              list: getList(head)
                                  .where((e) => e.isVisible)
                                  .toList())),
                      _helper.arrow()
                    ]);
              })),
            );
          }),
        ],
      ),
    );
  }

  Widget splitList(
      {required List list, required void Function(void Function()) setState}) {
    return SizedBox(
      width: double.infinity,
      child: list.isEmpty
          ? Text('Select $head',
              style: stylesWorkSans(
                  fontSize: 16,
                  color: const Color(0xFF808080).withOpacity(0.35),
                  fontWeight: FontWeight.w500))
          : Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 0.0,
              runSpacing: 2,
              children: [
                ...List.generate(
                    list.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: InkWell(
                            onTap: () {
                              list[index].isVisible = !list[index].isVisible;
                              setState(() {});
                            },
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFB0E0E6),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(getText(list[index]),
                                        style: stylesWorkSans()),
                                    const Icon(Icons.close,
                                        size: 18, color: Color(0xFF545454)),
                                  ],
                                )),
                          ),
                        ))
              ],
            ),
    );
  }
}

class _Helper<T> {
  final String head;
  final List Function(String) getList;
  final String Function(T) getText;
  final bool isSearch;
  final bool isMutliSelection;
  _Helper(
      {required this.head,
      required this.getList,
      required this.getText,
      required this.isSearch,
      required this.isMutliSelection});
  void Function(void Function())? setState;
  bool isShow = false;
  final GlobalKey boxKey = GlobalKey();

  Widget arrow() {
    return StatefulBuilder(builder: (context, st) {
      setState = st;
      return SizedBox(
          width: 25,
          height: 25,
          child: Icon(
              isShow
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFFC7C7CC)));
    });
  }

  Widget container({required Widget child}) {
    return Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 25),
        key: boxKey,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 0.8, color: const Color(0xFFC7C7CC))),
        child: child);
  }

  Future<dynamic> onTap(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    _Position position = _Position.center;
    List data = getList(head);
    final RenderBox renderBox =
        boxKey.currentContext!.findRenderObject() as RenderBox;
    final tabPosition = renderBox.localToGlobal(Offset.zero);
    double scrHeight = MediaQuery.sizeOf(context).height;
    double scrWidth = MediaQuery.sizeOf(context).width;
    double boxWidth = renderBox.size.width;
    double top = (tabPosition.dy + renderBox.size.height) - 25;
    double bottom = (scrHeight - top) + (renderBox.size.height - 25);
    double left = tabPosition.dx;
    double right = scrWidth - (boxWidth + left);
    double dialogHeight = (data.length + (isSearch ? 1 : 0)) * 45;
    /*Check Dialog Position<*/
    if (bottom > 110 && dialogHeight <= (bottom + (45 * 5))) {
      position = _Position.bottom;
    } else if (top > 110 && dialogHeight <= (top + (45 * 5))) {
      position = _Position.top;
    }
    /*Check Dialog Position>*/
    if (data.isNotEmpty) {
      isShow = true;
      if (setState != null) setState!(() {});
      dynamic value = await showDialog(
          barrierColor:
              position == _Position.center ? null : Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return _DialogDropDown(
                padding: position == _Position.center
                    ? EdgeInsets.only(
                        top: 15, left: left, right: right, bottom: 15)
                    : position == _Position.bottom
                        ? EdgeInsets.only(top: top, left: left)
                        : EdgeInsets.only(bottom: bottom, left: left),
                isSearch: isSearch,
                list: data,
                position: position,
                width: boxWidth,
                getText: (dd) => getText(dd as T),
                isMutliSelection: isMutliSelection);
          });
      isShow = false;
      if (setState != null) setState!(() {});
      return value;
    }
  }
}

class _DialogDropDown extends StatelessWidget {
  final List list;
  final Function(dynamic) getText;
  final double width;
  final bool isMutliSelection;
  final bool isSearch;
  final _Position position;
  final EdgeInsets padding;
  _DialogDropDown(
      {required this.list,
      required this.getText,
      required this.width,
      required this.isMutliSelection,
      required this.isSearch,
      required this.position,
      required this.padding});
  final TextEditingController searchTxtEdtCon = TextEditingController();
  late ValueNotifier<List> listNotifier = ValueNotifier(list);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment:
            position == _Position.center ? Alignment.center : Alignment.topLeft,
        child: Container(
          constraints: BoxConstraints(
              minWidth: width + padding.left + padding.right,
              maxWidth: width + padding.left + padding.right),
          child: Dialog(
            insetPadding: padding,
            elevation: 0,
            surfaceTintColor: const Color(0xFFF2F8FC),
            alignment: position == _Position.center
                ? Alignment.center
                : position == _Position.bottom
                    ? Alignment.topRight
                    : Alignment.bottomRight,
            child: Card(
              margin: EdgeInsets.zero,
              surfaceTintColor: const Color(0xFFF2F8FC),
              shadowColor: const Color(0xFFF2F8FC),
              elevation: 3.0,
              shape: BeveledRectangleBorder(
                  side: const BorderSide(color: Colors.black12, width: 0.5),
                  borderRadius: BorderRadius.circular(2)),
              child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSearch)
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                              autofocus: false,
                              onChanged: (value) {
                                listNotifier.value = list.where((data) {
                                  return getText(data)
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(
                                          searchTxtEdtCon.text.toLowerCase());
                                }).toList();
                              },
                              maxLines: 1,
                              cursorColor: Colors.blue.shade200,
                              style: stylesWorkSans(),
                              controller: searchTxtEdtCon,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search',
                                  fillColor: Colors.white,
                                  filled: true)),
                        ),
                      Flexible(
                        child: ValueListenableBuilder<List>(
                          valueListenable: listNotifier,
                          builder: (BuildContext context, List<dynamic> value,
                              Widget? child) {
                            return listBuilder(value);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 5),
                          child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }

  Widget listBuilder(List value) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, bottom: 0),
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: value.length,
          itemBuilder: (BuildContext context, int index) {
            return isMutliSelection
                ? mulltiBtn(context, value[index])
                : singleBtn(context, value[index]);
          },
        ),
      ),
    );
  }

  Widget singleBtn(BuildContext context, dynamic mdl) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      title: Text(
        getText(mdl),
        style: stylesWorkSans(),
      ),
      onTap: () {
        Navigator.of(context).pop(mdl);
      },
    );
  }

  Widget mulltiBtn(BuildContext context, dynamic mdl) {
    return Transform.scale(
      scale: 1.0,
      child: StatefulBuilder(builder: (context, setState) {
        return CheckboxListTile(
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            value: mdl.isVisible,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            activeColor: mdl.isVisible ? Colors.green : const Color(0xFF848482),
            title: Text(
              mdl.name,
              style: stylesWorkSans(),
            ),
            onChanged: (value) {
              setState(() {
                mdl.isVisible = !mdl.isVisible;
              });
            });
      }),
    );
  }
}
