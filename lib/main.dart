import 'package:flutter/material.dart';
import 'package:selfpackage/route/routes.dart';
import 'package:selfpackage/route/routes_name.dart';
import 'package:selfpackage/scr/util/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            color: const Color(0xFF1d4380),
            titleTextStyle: stylesWorkSans(color: Colors.white)),
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: RoutesName.routeList,
    );
  }
}
