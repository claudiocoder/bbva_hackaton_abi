import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/constants/app_theme.dart';
import 'package:hackaton_bbva_abi/routes.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      routes: Routes.routes,
      theme: themeData,
      home: Login(),
    );
  }
}
