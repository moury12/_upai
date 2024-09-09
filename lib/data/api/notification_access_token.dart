


import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:upai/presentation/Inbox/inbox.dart';

class NotificationAccessToken {


  // Future<String> getServiceKeyToken() async{
  //   'https://www.googleapis.com/auth/firebase.messaging';
  //   'https://www.googleapis.com/auth/userinfo.email';
  //   'https://www.googleapis.com/auth/firebase.messaging';
  // }


  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async => _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
       List<String>  fMessagingScope =
          ['https://www.googleapis.com/auth/firebase.database',
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/firebase.messaging'];

      final client = await clientViaServiceAccount(
        // To get Admin Json File: Go to Firebase > Project Settings > Service Accounts
        // > Click on 'Generate new private key' Btn & Json file will be downloaded

        // Paste Your Generated Json File Content
        ServiceAccountCredentials.fromJson(
            {
              "type": "service_account",
              "project_id": "chatappprac-d7a2b",
              "private_key_id": "1826e06b4a1dbfd40e8996864141e2261e1ecbf6",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC+vWe2izLD1LgO\nffF38vIn/QNOjzhL1i5ovyJODjJzXHwSrsW5kuT1ri/nhJrXsZRQh7aT5ZUXZSBO\n4lPA+Cf5H9BpN9OsVN8CrTVL97VStW2H/Qkx7Vjbn8MXeS9mTdSXGlsc85POQxSW\npe4awlTCiqhzKBuxPUQUi+OAYyiD1OAyrQt4+ho9qlRZmr0Ae8kG3M/7zCN3T4Tk\nvD/NWnXNRcFAF49GDW80DS9vxlRYsupk2Csh/QaOgh56nMUev+d95B9mIfI0THR1\ny45iNi3cChqYZyiJ3xjQ6ysXrL8F+/K4MhJJhobdEWsWKBoDxZbe9Z1rd6sZp3Tx\n2JHcS/sLAgMBAAECggEABxQ5fd784D0lvZsmZvv0L9BZZ8UZ/K2//pdrzjc2eSCY\nFdg45cvFX2oURHfsu6k1pqcUYbkC4QgZ4sObAlqGnt2m58v9UtqHHyICWRKIi/LI\nbcq4ciSe1SJA5KVudGunQoDLm+LDlanYrd5BQx37DlaEecDZBXZCiUhHbI1OXiIf\nMpVClZvq5f52kg4tSyeIOHYOx3s7mJ3LS+JQ7D8iaZl+gZUT0M1NIytEj7Z4Vl3y\nBz6Ty/bXkij1k67CLKDeYeDAzyCzXhXNGPW1PT8F+oo2gUgFI3kEBdoxBd0MRWRj\ng9iSoYCqXIjjs87ltrdtw851lWAld4Z78RkavyXUjQKBgQD7UnLOm5lXenJWFnqU\nsm+p+HCIsSG7wC+cFcIRV7Vnlc4h4P33T/od//v0Crpp0rRJ01Q6ohenjkdygYHb\nukUQfRsE889Fyd7npBjBOUG2wqNfOwSgYAwOZA2bk+x7VOR2ZCvbBCrDbMSmFybs\n74U129dRWBGLhVmg5dpbNU3IBwKBgQDCSkgyhZwRh9SBAzZ0bdSH4t9q/QgnYZlw\nwH5X6TbEp1uoLvMiqX5foDNnTp/8v7SCsxGMmi7yopW9qUTmh/SEuV6cz7tAJXin\n4hBz/zITeSimjrPV5uPcM+cOiQmkJjqYqx692181eiq/rmS9jfgFe6CTry/k3PwC\noegQa4IL3QKBgQCUCApLm+cEWcFC59aoAzo2eXl/aiYeeqMQYth+cpUNQHW8CtRM\nebUvOnpjUnZeopdC7NEuAA/Cx9FZpuKgU+UeQzJJBnrN9ovvEP7rwRft2FN2YkLl\nW+1+BHznaIfgVS6EdZhHVvsBRO3HjteEs8hY4va+mQssjQ0v8nNdSdZYvQKBgQCO\nC5ThKwHBZ1cbw2eKk8mwV1QUek39zMNLxdAZIa4i9GB0g27KxrRX4V3zh248cUPd\n0mFgNFFiny9u7FQtXvSMHKJpbw5thXfC9eolhEvuJMRtkSM1nYq1sVSaMeJUmoZ4\nm5LsJ3hiNqEOZsfMNgFAsPPjRU90uYOdwRVS++amGQKBgQChI+ib7oL1t9rIwOcl\nw6d3AhCbIEHQjIh0c30C8bgothkZiCYOIbwDbGfmB0MzEzZx7W2DQbKGRW5GMRAV\nKEU/xDGbDmsKOyRb6vCl9jIppui938ECcTkE6g4q9jMhe9Jtdt83DFFsJHF1lX2I\nS18cuV5TcAEtwL0Qywn/H2QE/w==\n-----END PRIVATE KEY-----\n",
              "client_email": "firebase-adminsdk-9i7v4@chatappprac-d7a2b.iam.gserviceaccount.com",
              "client_id": "113601408405534684204",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9i7v4%40chatappprac-d7a2b.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }



        ),
        fMessagingScope,
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //send notificartion request
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }
//
// //Fetch FCM Token
//   Future<String> getDeviceToken() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     String? token = await messaging.getToken();
//     print("token=> $token");
//     return token!;
//   }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          // handle interaction when app is active for android
          handleMessage(context, message);
        });
  }
//
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }
      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // // when app is terminated
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();

    // if (initialMessage != null) {
    //   handleMessage(context, initialMessage);
    // }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

    // Handle terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null && message.data.isNotEmpty) {
        handleMessage(context, message);
      }
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_importance_channel",
     "High Importance Notifications",
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true,

      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        sound: channel.sound,
      enableVibration: true,

      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: 'my_data',

      );
    });
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> handleMessage(
      BuildContext context,
      RemoteMessage message,
      ) async {
    print(
        "Navigating to appointments screen. Hit here to handle the message. Message data: ${message.data}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  InboxScreen(),
      ),
    );
  }
}
