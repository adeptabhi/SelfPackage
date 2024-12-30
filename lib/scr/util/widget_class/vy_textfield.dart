// ignore_for_file: must_be_immutable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/input_decoration.dart';
import 'package:selfpackage/scr/util/styles.dart';
import 'package:selfpackage/scr/util/widget.dart';

class VyTextField extends StatelessWidget {
  final TextEditingController txtCon;
  final String head;
  final String hintText;
  final bool isHideText;
  final bool isNumber;
  final int maxLine;
  final bool isRequired;
  final int? maxLen;
  final bool isEnable;
  final bool isCapitalLetter;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmmited;
  const VyTextField({
    super.key,
    required this.txtCon,
    this.head = '',
    this.hintText = "",
    this.isHideText = false,
    this.isNumber = false,
    this.maxLine = 1,
    this.isRequired = true,
    this.isCapitalLetter = false,
    this.maxLen,
    this.focusNode,
    this.isEnable = true,
    this.padding,
    this.preffixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmmited,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (head.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: wuHead(isRequired, head)),
          SizedBox(
            height: maxLine == 1 ? 45 : null,
            child: TextFormField(
                autofocus: false,
                enabled: isEnable,
                obscureText: isHideText,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmmited,
                focusNode: focusNode,
                textCapitalization: isCapitalLetter
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                keyboardType: isNumber
                    ? TextInputType.number
                    : maxLine == 1
                        ? TextInputType.text
                        : TextInputType.multiline,
                maxLines: maxLine,
                // cursorColor: ColorConst.appColor,
                style:
                    stylesWorkSans(fontSize: 16, fontWeight: FontWeight.w400),
                controller: txtCon,
                textAlignVertical: TextAlignVertical.top,
                inputFormatters: isNumber
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(maxLen),
                      ]
                    : null,
                decoration: txtInputDecoration().copyWith(
                    fillColor: isEnable
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFFF1F1F1),
                    filled: true,
                    hintText: hintText,
                    prefixIcon: preffixIcon,
                    suffixIcon: suffixIcon)),
          ),
        ],
      ),
    );
  }
}

class VyTextAutoComplete<T> extends StatefulWidget {
  final String head;
  final TextEditingController txtCon;
  final String hintText;
  final List<dynamic> Function(String) getList;
  final String Function(T) getText;
  final bool isRequired;
  final Function(T?) onChanged;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  late EdgeInsets padding;
  VyTextAutoComplete(
      {super.key,
      required this.head,
      this.hintText = "",
      required this.txtCon,
      required this.getList,
      required this.getText,
      this.isRequired = true,
      required this.onChanged,
      this.preffixIcon,
      this.suffixIcon,
      EdgeInsets? padding}) {
    this.padding =
        padding ?? const EdgeInsets.only(left: 10, right: 10, top: 10);
  }

  @override
  State<VyTextAutoComplete<T>> createState() => _VyTextAutoCompleteState<T>();
}

class _VyTextAutoCompleteState<T> extends State<VyTextAutoComplete<T>> {
  final GlobalKey _boxKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  @override
  void dispose() {
    super.dispose();
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.head.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: wuHead(widget.isRequired, widget.head)),
          CompositedTransformTarget(
            link: _layerLink,
            child: SizedBox(
                key: _boxKey,
                child: VyTextField(
                  txtCon: widget.txtCon,
                  hintText: widget.hintText,
                  preffixIcon: widget.preffixIcon,
                  suffixIcon: widget.suffixIcon,
                  padding: const EdgeInsets.all(0),
                  onChanged: (p) => onType(context: context, txt: p),
                )),
          ),
        ],
      ),
    );
  }

  void onType({required BuildContext context, required String txt}) {
    bool isBottom = true;
    List<T> data = txt.isEmpty ? [] : widget.getList(widget.head).cast<T>();
    T? temp;
    for (T mdl in data) {
      if (widget.getText(mdl).toLowerCase() == txt.toLowerCase()) {
        temp = mdl;
        break;
      }
    }
    widget.onChanged(temp);
    _removeOverlay();
    final RenderBox renderBox =
        _boxKey.currentContext!.findRenderObject() as RenderBox;
    final tabPosition = renderBox.localToGlobal(Offset.zero);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;
    double scrHeight = MediaQuery.sizeOf(context).height - keyboardHeight;
    double boxWidth = renderBox.size.width;
    double boxHeight = renderBox.size.height;
    double top = (tabPosition.dy + renderBox.size.height) + 25;
    double bottom = (scrHeight - top) + (renderBox.size.height - 25);
    data = data
        .where((e) => widget.getText(e).toLowerCase().contains(txt))
        .toList();
    double dialogHeight = data.length * 45;
    double bottomBuildArea = scrHeight - (tabPosition.dy + 25);
    double topBuildArea = scrHeight - (bottom + renderBox.size.height + 40);
    if (bottomBuildArea < dialogHeight && topBuildArea < dialogHeight) {
      isBottom = bottomBuildArea > topBuildArea;
    } else if (bottomBuildArea > 45 * 4 ||
        bottomBuildArea > 110 && dialogHeight <= (bottom + (45 * 4))) {
      isBottom = true;
    } else {
      isBottom = false;
    }
    if (data.isNotEmpty) {
      _showOverlay(
          isBottom: isBottom,
          context: context,
          boxWidth: boxWidth,
          boxHeight: boxHeight,
          height: isBottom ? bottomBuildArea : topBuildArea,
          data: data);
    }
  }

  void _showOverlay(
      {required bool isBottom,
      required BuildContext context,
      required double boxWidth,
      required double height,
      required double boxHeight,
      required List<T> data}) {
    _overlayEntry = OverlayEntry(builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: CompositedTransformFollower(
          followerAnchor: isBottom ? Alignment.topLeft : Alignment.bottomLeft,
          link: _layerLink,
          offset: Offset(0, isBottom ? boxHeight : 0),
          child: Align(
            alignment: isBottom ? Alignment.topLeft : Alignment.bottomLeft,
            child: Container(
              constraints: BoxConstraints(
                  minWidth: boxWidth,
                  maxWidth: boxWidth,
                  minHeight: 45,
                  maxHeight: height),
              child: Material(
                elevation: 0,
                color: const Color(0xFFF2F8FC),
                child: Card(
                  margin: EdgeInsets.zero,
                  surfaceTintColor: const Color(0xFFF2F8FC),
                  shadowColor: const Color(0xFFF2F8FC),
                  elevation: 3.0,
                  shape: BeveledRectangleBorder(
                      side: const BorderSide(color: Colors.black12, width: 0.5),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10, bottom: 0),
                    child: Scrollbar(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return singleBtn(context, data[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget singleBtn(BuildContext context, dynamic mdl) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      title: Text(
        widget.getText(mdl),
        style: stylesWorkSans(),
      ),
      onTap: () {
        widget.txtCon.text = widget.getText(mdl);
        _removeOverlay();
        widget.onChanged(mdl);
      },
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
