import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
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
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text('Flutter notification demo'),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: showNotification,
              child: new Text(
                'showNotification',
              ),
            ),
            RaisedButton(
              onPressed: cancelNotification,
              child: new Text(
                'cancelNotification',
              ),
            ),
            RaisedButton(
              onPressed: scheduleNotification,
              child: new Text(
                'scheduleNotification',
              ),
            ),
            RaisedButton(
              onPressed: showBigPictureNotification,
              child: new Text(
                'showBigPictureNotification',
              ),
            ),
            RaisedButton(
              onPressed: showNotificationMediaStyle,
              child: new Text(
                'showNotificationMediaStyle',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      color: Colors.red,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics,iOS: null);
    await flutterLocalNotificationsPlugin.show(
        0, 'notification title', 'notification body', platformChannelSpecifics);
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        contentTitle: 'flutter devs',
        htmlFormatContentTitle: true,
        summaryText: 'summaryText',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(android:androidPlatformChannelSpecifics,iOS: null);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
       android: androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android:android,iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }
}

class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}