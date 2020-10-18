import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hackaton_bbva_abi/services/dataService.dart';
import 'firestore.dart';

class PushNotificationsManager {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  void initFireMessaging(phoneNumber) {

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        DataService().setData(message["data"]["type"], message["data"]["emoji"], message["data"]["text"]);

      },
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: $message  hola el mesaggge ");
        DataService().setData(message["data"]["type"], message["data"]["emoji"], message["data"]["text"]);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        DataService().setData(message["data"]["type"], message["data"]["emoji"], message["data"]["text"]);

      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);

      DataBaseService().createDataTokenAuth(phoneNumber, token);
    });
  }
}