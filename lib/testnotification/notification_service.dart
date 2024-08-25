import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationService{

  //initialize plugin instance
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> onDidReceiveNotificationResponse(NotificationResponse notificationResponse)async{

}
  //ini notification plugin
static Future<void> init()async{
  //define the android  initialization setting
  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

  //combine initialization settings
  const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings
  );

  //initialize plugin
  await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
  );


  //request permission
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>
    ()?.requestNotificationsPermission();


}
  //showInstant notification

  static Future<void> showInstannotification(String title,String body)async{
    //define notification details
    const NotificationDetails platformChannelSpecific = NotificationDetails(
      android: AndroidNotificationDetails("channel_id", "channel_name",
      importance: Importance.high,
      priority: Priority.high,

      )
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecific);
  }


// show schedule notification
  static Future<void> showScheduleNotification(String title,String body,DateTime scheduledTime)async{
    //define notification details
    const NotificationDetails platformChannelSpecific = NotificationDetails(
        android: AndroidNotificationDetails("channel_id", "channel_name",
          importance: Importance.high,
          priority: Priority.high,

        )
    );

    await flutterLocalNotificationsPlugin. zonedSchedule(0, title, body,tz.TZDateTime.from(scheduledTime, tz.local), platformChannelSpecific,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime
    );

  }

}