import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Account/view.dart';
import 'package:kaydi_mobile/UI/CreateList/view.dart';
import 'package:kaydi_mobile/UI/Home/view.dart';
import 'package:kaydi_mobile/UI/List/CreateTask/view.dart';
import 'package:kaydi_mobile/UI/List/Settings/Search/view.dart';
import 'package:kaydi_mobile/UI/List/Settings/view.dart';
import 'package:kaydi_mobile/UI/List/view.dart';
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

      //List
      buildRoute(
        RouteName.CREATE_LIST,
        const CreateListView(),
      ),
      buildRoute(
        RouteName.TODOLIST,
        const TodoListView(),
      ),
      buildRoute(
        RouteName.CREATE_TASK,
        const CreateTaskView(),
        millisecond: 200,
        transition: Transition.fadeIn,
      ),
      buildRoute(
        RouteName.LIST_SETTINGS,
        const TodoListSettingsView(),
        millisecond: 200,
        transition: Transition.fadeIn,
      ),
      buildRoute(
        RouteName.LIST_SEARCH,
        const TodoListSearchView(),
        millisecond: 200,
        transition: Transition.fadeIn,
      ),

      //account
      buildRoute(
        RouteName.ACCOUNT,
        const AccountView(),
      ),
    ];

GetPage<dynamic> buildRoute(
  String pageUrl,
  Widget page, {
  Object? arguments,
  List<GetPage<dynamic>>? children,
  Curve? curve,
  Transition? transition,
  int? millisecond,
}) {
  return GetPage(
    curve: curve ?? Curves.easeInOut,
    name: pageUrl,
    arguments: arguments,
    page: () => page,
    children: children ?? [],
    middlewares: [MyMiddelware()],
    transition: transition ?? Transition.rightToLeft,
    transitionDuration: Duration(milliseconds: millisecond ?? 400),
  );
}

class MyMiddelware extends GetMiddleware {
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    Get.focusScope?.unfocus();
    return super.onBindingsStart(bindings);
  }
}
