import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

void loginWithGoogle() {
  RouteManager.goRouteAndRemoveBefore(RouteName.HOME);
}

