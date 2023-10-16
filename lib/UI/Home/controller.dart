import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
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

void switchList(String? v) async {
  ListsController c = Get.put(ListsController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  if (v == IKey.CLOUD.name.tr) {
    var dneme = await CloudManager.getCollection(CloudManager.USER_LISTS)
        .where('user_id', isEqualTo: auth.currentUser?.uid)
        .get();

    List<String> listeler = [];

    for (QueryDocumentSnapshot document in dneme.docs) {
      listeler.add(document['list_id']);
    }
    List<ListElement> contents = [];

    for (String listId in listeler) {
      DocumentSnapshot listDocument = await CloudManager.getDoc(CloudManager.LISTS, listId).get();
      if (listDocument.exists) {
        contents.add(
          ListElement.fromJson(
            jsonDecode(
              jsonEncode(listDocument.data()),
            ),
          ),
        );
      }
    }
    c.list.value = contents;
  } else {}
}
