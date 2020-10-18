import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hackaton_bbva_abi/services/dataService.dart';
import 'firestore.dart';
import 'package:flutter/material.dart';
import '../services/dataService.dart';

class PushNotificationsManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  void initFireMessaging(phoneNumber) {
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);

      DataBaseService().createDataTokenAuth(phoneNumber, token);
    });
  }

  listenNotify(BuildContext context) async {
    await _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  
}
