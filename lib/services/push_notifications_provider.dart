import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hackaton_bbva_abi/services/dataService.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final data = new DataService();

  final _mesanjesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mesanjesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print('====Token=====');
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('===============OnMessage==============');
    print('message: $message');
    data.setData(
      message['data']['type'],
      message['data']['emoji'],
      message['data']['text'],
      message['data']['source'],
      message['data']['destination'],
      message['data']['amount'],
    );
    _mesanjesStreamController.sink.add('ticket');
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('===============OnLaunch==============');
    print('launch: $message');
    data.setData(
      message['data']['type'],
      message['data']['emoji'],
      message['data']['text'],
      message['data']['source'],
      message['data']['destination'],
      message['data']['amount'],
    );
    _mesanjesStreamController.sink.add('ticket');
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('===============onResume==============');
    print('resume: $message');
    data.setData(
      message['data']['type'],
      message['data']['emoji'],
      message['data']['text'],
      message['data']['source'],
      message['data']['destination'],
      message['data']['amount'],
    );
    _mesanjesStreamController.sink.add('ticket');
  }

  dispose() {
    _mesanjesStreamController?.close();
  }
}
