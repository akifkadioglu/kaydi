import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/app.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/notifications/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:kaydi_mobile/core/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> backgroundMessage(RemoteMessage message) async {
  final notificationData = (message.notification?.toMap() ?? {}).map(
    (key, value) => MapEntry(key, value.toString()),
  );
  print(notificationData);
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: message.messageId.hashCode,
      channelKey: 'alerts',
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: notificationData,
    ),
  );
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await NotificationManager().initNotifications();
  HomeWidget.setAppGroupId('com.kaydiApp');
  FirebaseMessaging.onBackgroundMessage(backgroundMessage);

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppModel? appModel;
  @override
  void initState() {
    super.initState();
    var app = StorageManager.instance.getData(SKey.APP);
    var notAllowedNotifications = StorageManager.instance.getData(SKey.NOTIFICATIONS);
    var lists = StorageManager.instance.getData(SKey.LISTS);
    if (app == null) {
      StorageManager.instance.setData(
        SKey.APP,
        json.encode(AppModel(
          id: "",
          token: "",
          name: "",
          email: "",
          language: Get.deviceLocale.toString() == "" ? "en_US" : Get.deviceLocale.toString(),
        )),
      );
    }
    if (lists == null) {
      StorageManager.instance.setData(
        SKey.LISTS,
        json.encode(ListTaskModel(list: [])),
      );
    }
    if (notAllowedNotifications == null) {
      StorageManager.instance.setData(
        SKey.NOTIFICATIONS,
        json.encode([]),
      );
    }

    appModel = appModelFromJson(StorageManager.instance.getData(SKey.APP));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.AppName,
      theme: ThemeData(),
      supportedLocales: [
        Languages.ENGLISH,
        Languages.TURKISH,
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      fallbackLocale: Languages.ENGLISH,
      translations: AppTranslations(),
      locale: appModel?.language == 'en_US' ? Languages.ENGLISH : Languages.TURKISH,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: RouteName.LOADING,
      getPages: appRoutes,
      unknownRoute: unknownRoute,
    );
  }
}
