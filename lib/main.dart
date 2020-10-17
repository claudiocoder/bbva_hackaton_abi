import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/constants/app_theme.dart';
// import 'package:hackaton_bbva_abi/constants/strings.dart';
import 'package:hackaton_bbva_abi/routes.dart';
import 'package:hackaton_bbva_abi/ui/splash.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.routes,
      theme: themeData,
      home: SplashScreen(),
    );
  }
}
