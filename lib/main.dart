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
import './services/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    final PushNotificationsManager noti = new PushNotificationsManager();
    noti.listenNotify(context);
  }

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
