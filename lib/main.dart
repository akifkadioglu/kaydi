import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:kaydi_mobile/core/routes/routes.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.AppName,
      themeMode: ThemeMode.dark,
      theme: ThemeData(colorScheme: lightColorScheme),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      initialRoute: RouteName.LOGIN,
      getPages: appRoutes,
      unknownRoute: unknownRoute,
    );
  }
}
