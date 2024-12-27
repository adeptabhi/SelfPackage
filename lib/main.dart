import 'package:flutter/material.dart';
import 'package:selfpackage/route/routes.dart';
import 'package:selfpackage/route/routes_name.dart';

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
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: RoutesName.routeList,
    );
  }
}
