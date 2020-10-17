import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/ui/splash.dart';
import 'package:hackaton_bbva_abi/ui/picture/picture.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String picture = '/picture';
  static const String login = './login';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    login: (context) => Login(),
    picture: (context) => PictureScreen(),
  };
}