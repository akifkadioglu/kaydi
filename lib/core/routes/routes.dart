import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Home/view.dart';
import 'package:kaydi_mobile/UI/Login/view.dart';
import 'package:kaydi_mobile/UI/Unknown/unknown.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

get unknownRoute => buildRoute(
      '/unknown',
      const UnknownView(),
    );

get appRoutes => [
      //Auth
      buildRoute(
        RouteName.LOGIN,
        const LoginView(),
      ),
      buildRoute(
        RouteName.HOME,
        const HomeView(),
      ),
    ];

GetPage<dynamic> buildRoute(
  String pageUrl,
  Widget page, {
  Object? arguments,
  List<GetPage<dynamic>>? children,
  Curve? curve,
}) {
  return GetPage(
    curve: curve ?? Curves.easeInOut,
    name: pageUrl,
    arguments: arguments,
    page: () => page,
    children: children ?? [],
    middlewares: [MyMiddelware()],
    transition: Transition.cupertino,
    transitionDuration: Duration(milliseconds: 400),
  );
}

class MyMiddelware extends GetMiddleware {
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    Get.focusScope?.unfocus();
    return super.onBindingsStart(bindings);
  }
}
