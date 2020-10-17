import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/constants/app_theme.dart';
import 'package:hackaton_bbva_abi/routes.dart';
import 'package:hackaton_bbva_abi/services/authService.dart';
import 'package:hackaton_bbva_abi/ui/audio/audio.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackaton_bbva_abi/ui/picture/picture.dart';
import 'package:hackaton_bbva_abi/ui/ticket/ticket.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      theme: themeData,
      home: AuthService().handleAuth(),
    );
  }
}
