import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/constants/assets.dart';
import 'package:hackaton_bbva_abi/routes.dart';
import 'package:hackaton_bbva_abi/services/firestore.dart';
import 'package:hackaton_bbva_abi/services/notification.dart';
import 'package:hackaton_bbva_abi/widgets/app_icon_widget.dart';

// import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
//i mport 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Center(
          child: AppIconWidget(image: Assets.appLogo),
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.of(context).pushReplacementNamed(Routes.picture);
  }
}
