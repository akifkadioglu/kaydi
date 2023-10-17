import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kaydi_mobile/UI/Home/view_controller.dart';
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

void getCloud() async {
  HomeViewController homeController = Get.put(HomeViewController());
  homeController.setLoading;
  bool result = await InternetConnectionChecker().hasConnection;
  final FirebaseAuth auth = FirebaseAuth.instance;
  if (!result || auth.currentUser == null) {
    homeController.setLoading;
    return;
  }
  ListsController c = Get.put(ListsController());

  var dneme = await CloudManager.getCollection(CloudManager.USER_LISTS)
      .where('user_id', isEqualTo: auth.currentUser?.uid)
      .get();

  List<String> listIds = [""];

  for (QueryDocumentSnapshot document in dneme.docs) {
    listIds.add(document['list_id']);
  }
  var x = await CloudManager.getCollection(CloudManager.LISTS).where('id', whereIn: listIds).get();
  c.list.addAll(x.docs.map((e) {
    var task = (e['task'] as List).map(
      (a) => Task(
        id: a['id'],
        task: a['task'],
        isChecked: a['is_checked'],
      ),
    );
    return ListElement(
      id: e['id'],
      name: e['name'],
      task: task.toList(),
      inCloud: e['in_cloud'],
    );
  }).toList());

  c.list.sort((a, b) => a.name.compareTo(b.name));
  homeController.setLoading;
}
