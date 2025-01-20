import 'package:flutter/material.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/styles.dart';

class TabBarOut {
  String title;
  List<IdNameMdl> list;
  TabController? tabController;
  bool isScrollable;
  TabBarOut(
      {required this.title,
      required this.list,
      this.isScrollable = false,
      this.tabController});
  AppBar appBar() {
    return AppBar(
      centerTitle: false,
      leadingWidth: 50,
      titleSpacing: 0,
      toolbarHeight: list.isNotEmpty ? 100 : 65,
      title:
          Text(title, style: stylesWorkSans(fontSize: 16, color: Colors.white)),
      bottom: list.isNotEmpty
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: ColoredBox(
                color: const Color(0xFFDCDCDC),
                child: _tabBar(),
              ),
            )
          : null,
    );
  }

  TabBar _tabBar() {
    return TabBar(
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      dividerColor: Colors.grey,
      dividerHeight: 0.6,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: stylesWorkSans(fontSize: 14, color: const Color(0xFF252E3B)),
      unselectedLabelStyle:
          stylesWorkSans(fontSize: 14, color: const Color(0xFF808A98)),
      tabAlignment: isScrollable ? TabAlignment.start : null,
      controller: tabController,
      isScrollable: isScrollable,
      tabs: [
        ...List.generate(
            list.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(top: 9, bottom: 9),
                  child: Text(list[index].name),
                ))
      ],
    );
  }
}
