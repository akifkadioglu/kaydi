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
      RouteManager.normalRoute(RouteName.ACCOUNT);
      break;
    default:
  }
}
