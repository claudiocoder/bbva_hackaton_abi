import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/ui/audio/audio.dart';
import 'package:hackaton_bbva_abi/ui/end/operationStatus.dart';
import 'package:hackaton_bbva_abi/ui/splash.dart';
import 'package:hackaton_bbva_abi/ui/picture/picture.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';
import 'package:hackaton_bbva_abi/ui/signature/signature.dart';
import 'package:hackaton_bbva_abi/ui/ticket/ticket.dart';
import 'package:hackaton_bbva_abi/ui/finger/finger.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = 'splash';
  static const String picture = 'picture';
  static const String audio = 'audio';
  static const String login = 'login';
  static const String signature = 'signature';
  static const String ticket = 'ticket';
  static const String finger = '/finger';
  static const String status = '/end';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    login: (context) => Login(),
    picture: (context) => PictureScreen(),
    audio: (context) => AudioPage(),
    signature: (context) => SignatureScreen(),
    ticket: (context) => TicketPage(),
    finger: (context) => FingerScreen(),
    status: (context) => StatusPage()
  };
}
