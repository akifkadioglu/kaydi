import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

void route(index) {
  switch (index) {
    case 0:
      break;
    case 1:
      RouteManager.normalRoute(RouteName.CREATE_LIST);
      break;
    case 2:
      if (FirebaseAuth.instance.currentUser != null) {
        RouteManager.normalRoute(RouteName.ACCOUNT);
      } else {
        RouteManager.goRouteAndRemoveBefore(RouteName.LOGIN);
      }
      break;
    default:
  }
}
