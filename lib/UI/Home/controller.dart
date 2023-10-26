import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kaydi_mobile/core/ads/service.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
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

Future<dynamic> loadBannerAd() async {
  bool result = await InternetConnectionChecker().hasConnection;

  if (result) {
    BannerAd banner = await AdMobService().getAd();
    return banner;
  }
  return null;
}

Stream<QuerySnapshot> getCollectionStream() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return CloudManager.getCollection(CloudManager.USER_LISTS)
      .where("user_id", isEqualTo: auth.currentUser?.uid)
      .snapshots();
}

void handleDataChange(QuerySnapshot? snapshot) async {
  ListsController c = Get.put(ListsController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool result = await InternetConnectionChecker().hasConnection;
  if (snapshot == null || !result || auth.currentUser == null) {
    return;
  }

  for (var change in snapshot.docChanges) {
    if (change.type == DocumentChangeType.added) {
      var x = await CloudManager.getDoc(CloudManager.LISTS, change.doc["list_id"]).get();
      var task = (x['task'] as List).map(
        (a) => Task(
          id: a['id'],
          task: a['task'],
          isChecked: a['is_checked'],
        ),
      );
      c.list.addIf(
        c.list.firstWhereOrNull((element) => element.id == x['id']) == null,
        ListElement(
          id: x['id'],
          name: x['name'],
          task: task.toList(),
          inCloud: x['in_cloud'],
        ),
      );
    } else if (change.type == DocumentChangeType.removed) {
      c.list.removeWhere((element) => element.id == change.doc["list_id"]);
    }
  }
  c.list.sort((a, b) => a.name.compareTo(b.name));
}
