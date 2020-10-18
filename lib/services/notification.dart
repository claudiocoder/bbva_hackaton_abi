import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hackaton_bbva_abi/services/dataService.dart';
import '../routes.dart';
import 'firestore.dart';
import 'package:flutter/material.dart';

class PushNotificationsManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
        DataService().setData(message["data"]["type"], message["data"]["emoji"],
            message["data"]["text"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: $message  hola el mesaggge ");
        DataService().setData(message["data"]["type"], message["data"]["emoji"],
            message["data"]["text"]);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        DataService().setData(message["data"]["type"], message["data"]["emoji"],
            message["data"]["text"]);
        navigate(message["data"]["type"].toString(), context);
      },
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  navigate(name, context) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Context: $context');
    print('>>>>>>>>>>>>>>>>>>>>Name: $name');
    name = 'audio';
    switch (name) {
      case 'audio':
        print('??????????????????????>>>AUDIo');
        Navigator.of(context).pushNamed('audio');
        break;
      case Routes.picture:
        Navigator.of(context).pushReplacementNamed(Routes.picture);
        break;
      default:
        Navigator.of(context).pushReplacementNamed(Routes.signature);
        break;
    }
  }
}
