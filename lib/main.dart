import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'repositories/favorites/favorites.dart';
import 'repositories/history/history.dart';
import 'repositories/notifications/notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Инициализация зависимостей
  // Инициализация Realm'a
  final realm = _initRealm();
  // Инициализациы SharedPreferences
  final sharedPreferences = await _initSharedPreferences();
  await _initFirebase();
  // Создаем репозиторий уведомлений
  final notificationRepo = _initNotificatiobRepository();
  // Инициализация уведомлений
  await notificationRepo.initializeNotifications();
  notificationRepo.getFCMToken().then((token) => log('FCM Token: $token'));
  // Инциализация всего конфига приложения (зависимостей)
  final appConfig = _initAppConfig(realm, sharedPreferences);

  runApp(MyRhymerApp(appConfig: appConfig));
}

AppConfig _initAppConfig(Realm realm, SharedPreferences sharedPreferences) {
  return AppConfig(realm: realm, sharedPreferences: sharedPreferences);
}

NotificationRepository _initNotificatiobRepository() {
  return NotificationRepository(
    firebaseMessaging: FirebaseMessaging.instance,
    localNotifications: FlutterLocalNotificationsPlugin(),
  );
}

Future<FirebaseApp> _initFirebase() =>
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

Future<SharedPreferences> _initSharedPreferences() async =>
    await SharedPreferences.getInstance();

Realm _initRealm() {
  return Realm(
    Configuration.local([HistoryRhymes.schema, FavoriteRhymes.schema]),
  );
}
