import 'package:flutter/material.dart';
import 'package:notificaciones/src/page/home_page.dart';
import 'package:notificaciones/src/page/message_page.dart';
import 'package:notificaciones/src/services/push_nitification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationService.messageStream.listen((message) {
      print('MyApp $message');
      navigatorKey.currentState!.pushNamed('message', arguments: message);
      final snackbar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        navigatorKey: navigatorKey, //navegar
        scaffoldMessengerKey: messengerKey, //mostrar snack
        routes: {'home': (_) => HomePage(), 'message': (_) => MessagePage()});
  }
}
