import 'package:flutter/material.dart';
import 'package:selfpackage/model/util_mdl.dart';
import 'package:selfpackage/scr/util/widget_class/tabbar_out.dart';
import 'package:selfpackage/scr/util/widget_class/tapbar_in.dart';

class TabBarScr extends StatefulWidget {
  const TabBarScr({super.key});
  @override
  State<TabBarScr> createState() => _TabBarScrState();
}

class _TabBarScrState extends State<TabBarScr> {
  List<IdNameMdl> list = [
    IdNameMdl(id: 1, name: 'Tab1'),
    IdNameMdl(id: 2, name: 'Tab2'),
    IdNameMdl(id: 3, name: 'Tab3')
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: list.length,
      child: Scaffold(
          appBar: TabBarOut(title: "Tabbar", list: list).appBar(),
          body: TabBarView(
              children: List.generate(
                  list.length, (index) => _TabTop(idNameMdl: list[index])))),
    );
  }
}

class _TabTop extends StatefulWidget {
  final IdNameMdl idNameMdl;
  const _TabTop({required this.idNameMdl});

  @override
  State<_TabTop> createState() => _TabTopState();
}

class _TabTopState extends State<_TabTop> {
  final List<IdNameMdl> list = [
    IdNameMdl(id: 1, name: 'InTab1'),
    IdNameMdl(id: 2, name: 'InTab2'),
    IdNameMdl(id: 3, name: 'InTab3')
  ];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBarIn(
            list: list,
            onTap: (p0) {
              setState(() {
                i = p0;
              });
            }),
        const SizedBox(height: 10),
        Expanded(
            child: Center(
                child: Text('${widget.idNameMdl.name} : ${list[i].name}')))
      ],
    );
  }
}
