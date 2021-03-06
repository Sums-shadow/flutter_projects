import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SumsNotification{
String titre, contenu;


 static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init(){
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
       android: initializationSettingsAndroid,iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }
   Future onSelectNotification(String payload) {
    print(payload);
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return NewScreen(
    //     payload: payload,
    //   );
    // }));
  }
 static showNotification(titre, contenu) async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android:android, iOS:iOS);
    await flutterLocalNotificationsPlugin.show(
        0, titre, contenu, platform,
        payload: 'Welcome to the Local Notification demo ');
  }
}