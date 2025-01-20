import 'package:flutter/material.dart';
import 'package:selfpackage/route/routes_name.dart';

class RouteListScr extends StatelessWidget {
  const RouteListScr({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 60,
        titleSpacing: 0,
        title: const Text('Route List'),
      ),
      body: ListView(
        children: [
          screen(context, 'Drop Down', RoutesName.dropdown),
          screen(context, 'Text Field', RoutesName.textfield),
          screen(context, 'Data Table', RoutesName.dataTable),
          screen(context, 'Tab Bar', RoutesName.tabbar),
        ],
      ),
    );
  }

  Widget screen(BuildContext context, String name, String routeName) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(name),
        shape: Border.all(width: 0.5),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}
