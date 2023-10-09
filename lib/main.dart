import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:kaydi_mobile/core/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
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
      locale: Get.deviceLocale,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: RouteName.LOGIN,
      getPages: appRoutes,
      unknownRoute: unknownRoute,
    );
  }
}
