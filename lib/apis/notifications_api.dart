import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future init() async {
    var configAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    var configGeneral = InitializationSettings(android: configAndroid);
    _notifications.initialize(configGeneral);

    final details = await _notifications.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.payload);
    }

    _notifications.initialize(
      configGeneral,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'channel description',
            playSound: true,
            importance: Importance.max));
  }

  static Future scheduleNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime data,
  }) async {
    final location = tz.UTC;
    _notifications.zonedSchedule(id, title, body,
        tz.TZDateTime.from(data, location), await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
