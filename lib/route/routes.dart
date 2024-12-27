import 'package:flutter/material.dart';
import 'package:selfpackage/logic/msg.dart';
import 'package:selfpackage/route/routes_name.dart';
import 'package:selfpackage/scr/presentation/dropdown_scr.dart';
import 'package:selfpackage/scr/presentation/route_list_scr.dart';
import 'package:selfpackage/scr/presentation/textfield_scr.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    logInfo('Route', msg: '${settings.name}');

    switch (settings.name) {
      case RoutesName.routeList:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const RouteListScr(),
        );
      case RoutesName.dropdown:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DropDownScr(),
        );
      case RoutesName.textfield:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const TextFieldScr(),
        );
    }

    return null;
  }
}
