import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/ui/audio/audio.dart';
import 'package:hackaton_bbva_abi/ui/splash.dart';
import 'package:hackaton_bbva_abi/ui/picture/picture.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String picture = '/picture';
  static const String audio = '/audio';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    picture: (context) => PictureScreen(),
    audio: (context) => AudioPage(),
  };
}