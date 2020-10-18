import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/constants/assets.dart';
import 'package:hackaton_bbva_abi/routes.dart';
import 'package:hackaton_bbva_abi/services/dataService.dart';
import 'package:hackaton_bbva_abi/services/firestore.dart';

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
    final data = DataService().getData();
    Navigator.of(context).pushReplacementNamed(data['type'].toString()) ;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    //final data = DataService().getData();
    //   print('=======================================>>>>>>data $data');
    //   switch (data['type']) {
    //     case Routes.audio:
    //       Navigator.of(context).pushReplacementNamed(Routes.audio);
    //       break;
    //     case Routes.picture:
    //       Navigator.of(context).pushReplacementNamed(Routes.picture);
    //       break;
    //     default:
    //       Navigator.of(context).pushReplacementNamed(Routes.signature);
    //       break;
    //   }
    //Navigator.of(context).pushReplacementNamed(Routes.picture);
  }
}
