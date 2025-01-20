import 'package:flutter/material.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/styles.dart';

class TabBarIn extends StatelessWidget {
  final bool isScrollable;
  final List<IdNameMdl> list;
  final void Function(int)? onTap;
  const TabBarIn(
      {super.key, this.isScrollable = false, required this.list, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: DefaultTabController(
        length: list.length,
        child: TabBar(
          onTap: onTap,
          dividerColor: const Color(0xFF808A98),
          dividerHeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: const Color(0xFF1d4380),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFF1d4380), width: 2.5),
          ),
          labelStyle:
              stylesWorkSans(fontSize: 14, color: const Color(0xFF252E3B)),
          unselectedLabelStyle:
              stylesWorkSans(fontSize: 14, color: const Color(0xFF808A98)),
          isScrollable: isScrollable,
          tabAlignment: isScrollable ? TabAlignment.start : null,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          tabs: [
            ...List.generate(
                list.length,
                (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Text(list[index].name)))
          ],
        ),
      ),
    );
  }
}
