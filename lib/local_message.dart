import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalMessage {
  final AndroidInitializationSettings _androidSettings = AndroidInitializationSettings('ic_launcher');
  final IOSInitializationSettings _iosSettings = IOSInitializationSettings();
  final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();
  final AndroidNotificationDetails _androidInfo = AndroidNotificationDetails(
    'channel-id',
    'channel-name',
    'channel-description',
    styleInformation: BigTextStyleInformation(
      '',
      htmlFormatContent: true,
      htmlFormatTitle: true,
    ),
  );

  static int id = 0;

  late InitializationSettings _initializationSettings;
  late NotificationDetails _platformChannelSpecifics;

  LocalMessage() {
    _initializationSettings = InitializationSettings(android: _androidSettings, iOS: _iosSettings);
    _platformChannelSpecifics = NotificationDetails(android: _androidInfo, iOS: IOSNotificationDetails());
  }

  void initialize({required SelectNotificationCallback onSelectNotification}) {
    _notification.initialize(_initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future<void> onLaunchByMessage({required SelectNotificationCallback onSelectNotification}) async {
    final notificationAppLaunchDetails = await _notification.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null && notificationAppLaunchDetails.didNotificationLaunchApp) {
      final payload = notificationAppLaunchDetails.payload;
      onSelectNotification(payload);
    }
    return Future<void>.value();
  }

  void show({
    String? title,
    String? body,
    String? payload,
  }) {
    _notification.show(
      id++,
      title ?? '',
      body ?? '',
      _platformChannelSpecifics,
      payload: payload,
    );
  }
}
