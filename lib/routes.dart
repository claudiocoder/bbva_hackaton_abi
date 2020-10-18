import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/ui/audio/audio.dart';
import 'package:hackaton_bbva_abi/ui/splash.dart';
import 'package:hackaton_bbva_abi/ui/picture/picture.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';
import 'package:hackaton_bbva_abi/ui/signature/signature.dart';
import 'package:hackaton_bbva_abi/ui/ticket/ticket.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = 'splash';
  static const String picture = 'picture';
  static const String audio = 'audio';
  static const String login = 'login';
  static const String signature = 'signature';
  static const String ticket = 'ticket';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    login: (context) => Login(),
    picture: (context) => PictureScreen(),
    audio: (context) => AudioPage(),
    signature:(context) => SignatureScrenn(),
    ticket: (context) => TicketPage()
  };
}