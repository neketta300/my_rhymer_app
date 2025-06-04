import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class NotificationRepositoryI {
  Future<String?> getFCMToken();
  Future<void> initializeNotifications();
  Stream<RemoteMessage> get notificationStream;
}
