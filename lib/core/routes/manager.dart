import 'package:get/get.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

class RouteManager {
  static void normalRoute(String path, {Map<String, String>? parameters}) {
    Get.toNamed(path, parameters: parameters);
  }

  static void goRouteAndRemoveBefore(String path, {Map<String, String>? parameters}) {
    Get.offAllNamed(path, parameters: parameters);
  }

  static void goRouteAndRemoveBeforeExceptHome(String path, {Map<String, String>? parameters}) {
    Get.offAllNamed(RouteName.HOME);
    Get.toNamed(path, parameters: parameters);
  }
}
