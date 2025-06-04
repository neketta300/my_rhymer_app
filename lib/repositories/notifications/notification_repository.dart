import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_rhymer/repositories/notifications/notification_repository_interface.dart';

class NotificationRepository implements NotificationRepositoryI {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  NotificationRepository({
    required FirebaseMessaging firebaseMessaging,
    required FlutterLocalNotificationsPlugin localNotifications,
  }) : _firebaseMessaging = firebaseMessaging,
       _localNotifications = localNotifications;

  @override
  Future<String?> getFCMToken() async {
    // запрос на включения уведомлений
    await _firebaseMessaging.requestPermission();
    // получение FCM токена
    return _firebaseMessaging.getToken();
  }

  @override
  Future<void> initializeNotifications() async {
    // Настройка канала уведомлений для Android
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // Уникальный ID канала
      'High Importance Notifications', // Видимое название
      description:
          'This channel is used for important notifications.', // Описание
      importance: Importance.max, // Максимальный приоритет
    );

    // Создаем канал (только для Android)
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Подписываемся на входящие сообщения, когда приложение активно
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  @override
  Stream<RemoteMessage> get notificationStream => FirebaseMessaging.onMessage;

  // Внутренний метод для отображения локального уведомления
  // [message] - полученное сообщение от FCM
  void _showLocalNotification(RemoteMessage message) {
    _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          icon: 'ic_launcher',
        ),
      ),
    );
  }
}
