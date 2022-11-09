import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/navigation/routes.dart';
import 'package:service_bee/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Local_Notification/local_notification.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;


LocalNotification localNotification = LocalNotification();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  //  'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
  //sound: RawResourceAndroidNotificationSound('whistlesound')
);

const AndroidNotificationDetails firstNotificationAndroidSpecifics =
    AndroidNotificationDetails(
  'high_importance_channel', // id
  'High Importance Notifications', // title
//  'This channel is used for important notifications.',
//  sound: RawResourceAndroidNotificationSound('whistlesound'),
  playSound: true,
  importance: Importance.high,
  priority: Priority.high,
);

const NotificationDetails firstNotificationPlatformSpecifics =
    NotificationDetails(android: firstNotificationAndroidSpecifics);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // // setState()

  // //  sets
  // prefs.setString('status', "Pending");
  flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        //   'This channel is used for important notifications.',
        //   sound: RawResourceAndroidNotificationSound('whistlesound'),
        playSound: true,
        importance: Importance.high,
        priority: Priority.high,
      )),
      payload: jsonEncode({"Data": "Got it."}));

  // localNotification.showNotification(message.notification);
  print('background message ${message.notification!.body}');
  if (message.notification!.body == "You Can Now Accept The Orders") {
    FirebaseMessaging.onMessageOpenedApp.listen((snapshot) async {
      // print('ppoopopp');

      prefs.setString('status', "Pending");
      //Calls when the notification is been clicked.
      // localNotification.notificationRoute(snapshot.data);
      //  localNotification.showNotification(snapshot.notification);
    });
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Storage.instance.initializeStorage();
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  //globalSharedPref = await SharedPreferences.getInstance();
  Future.delayed(Duration(seconds: 5), () async {
    await localNotification.initializeLocalNotificationSettings();
  });

  // _notificationHandler();
  FirebaseMessaging.onMessage.listen((event) async {
    //  prefs.setString('status', "Pending");
   // localNotification.testNotification();
    // localNotification.showNotification(event.data.)
    localNotification.showNotification(event.data);
    print('event ${event.data['title']}');
    // localNotification.showNotification(event.notification);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((snapshot) async {
    print('ppoopopp');

    //  prefs.setString('status', "Pending");
    //Calls when the notification is been clicked.
    // localNotification.notificationRoute(snapshot.data);
    //  localNotification.showNotification(snapshot.notification);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.instance.navigatorKey,
      onGenerateRoute: generateRoute,
    );
  }
}
