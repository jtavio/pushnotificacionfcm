//E2:FE:A5:37:D7:5C:4A:AF:0B:EC:85:7E:F8:A3:20:4D:28:C7:13:FD

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;

  static StreamController<String> _messageStream =
      new StreamController.broadcast();

  //suscribirnos
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('background: ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No Data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('_onMessageHandler: ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No Data');
  }

  static Future _onOpenMessageApp(RemoteMessage message) async {
    print('_onOpenMessageApp: ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No Data');
  }

  static Future initializeApp() async {
    //push notification recibe token
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('token: $token');

    //handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageApp);

    //local notification
  }

  //cerrando el stream controller
  static closeStreams() {
    _messageStream.close();
  }
}
