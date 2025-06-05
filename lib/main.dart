import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'repositories/favorites/favorites.dart';
import 'repositories/history/history.dart';
import 'repositories/notifications/notifications.dart';

Future<void> main() async {
  // Инициализация зоны и обработки ошибок
  runZonedGuarded(
    () async {
      // 1. Обязательная инициализация Flutter
      WidgetsFlutterBinding.ensureInitialized();

      // 2. Загрузка конфигурации .env
      await dotenv.load(fileName: ".env");

      // 3. Инициализация Talker (логирование)
      final talker = TalkerFlutter.init();
      talker.debug('Application initialization started...');

      // Инициализация Talker для Bloc
      Bloc.observer = TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(
          printStateFullData: false,
          printEventFullData: false,
        ),
      );

      FlutterError.onError =
          (details) => talker.handle(details.exception, details.stack);

      try {
        final firebaseApp = await _initFirebase();
        talker.log(firebaseApp.options.projectId);
        final sharedPreferences = await _initSharedPreferences();
        final realm = _initRealm(); // Синхронная инициализация
        final notificationRepo = _initNotificationRepository();

        // 5. Инициализация уведомлений
        await notificationRepo.initializeNotifications();
        notificationRepo.getFCMToken().then(
          (token) => talker.debug('FCM Token: $token'),
        );

        // 6. Создание конфига приложения
        final appConfig = _initAppConfig(realm, sharedPreferences, talker);
        talker.debug('AppConfig initialized successfully');

        // 7. Запуск приложения
        runApp(MyRhymerApp(appConfig: appConfig));
      } catch (e, st) {
        talker.critical('Fatal initialization error', e, st);
        rethrow; // Можно добавить fallback UI или завершить приложение
      }
    },
    (error, stack) {
      // Глобальный обработчик ошибок
      final talker =
          TalkerFlutter.init(); // На случай, если ошибка произошла до инициализации Talker
      talker.handle(error, stack);
    },
  );
}

AppConfig _initAppConfig(
  Realm realm,
  SharedPreferences sharedPreferences,
  Talker talker,
) {
  return AppConfig(
    realm: realm,
    sharedPreferences: sharedPreferences,
    talker: talker,
  );
}

NotificationRepository _initNotificationRepository() {
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
