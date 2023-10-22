import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kaydi_mobile/UI/List/Settings/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/models/user_lists_model.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:kaydi_mobile/core/toast/manager.dart';

void checkCloud() {
  ListsController c = Get.put(ListsController());
  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  c.theList.value.inCloud = model.list.firstWhereOrNull((element) => element.id == c.theList.value.id)?.inCloud ?? true;
  c.theList.refresh();
}

void leaveFromList(String id) async {
  ListsController c = Get.put(ListsController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  model.list.removeWhere((element) => element.id == id);
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  c.list.removeWhere((element) => element.id == id);
  CloudManager.getCollection(CloudManager.USER_LISTS)
      .where(
        "user_id",
        isEqualTo: auth.currentUser?.uid ?? "",
      )
      .where(
        "list_id",
        isEqualTo: id,
      )
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
    snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
      doc.reference.delete();
    });
  });

  c.sendNotificationToListUsers((auth.currentUser?.displayName ?? "") + " listeden ayrıldı");

  CloudManager.getDoc(CloudManager.USER_LISTS, id).delete();
  c.list.refresh();
}

void moveToCloud(String id) async {
  ListsController c = Get.put(ListsController());
  TodoListSettingsViewController todoController = Get.put(TodoListSettingsViewController());

  todoController.setLoading;
  bool result = await InternetConnectionChecker().hasConnection;
  final FirebaseAuth auth = FirebaseAuth.instance;
  if (!result || auth.currentUser == null) {
    ToastManager.toast(translate(IKey.TOAST_2));
    todoController.setLoading;
    return;
  }

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  var element = model.list.firstWhereOrNull((element) => element.id == id);
  element?.inCloud = true;
  await CloudManager.getDoc(CloudManager.LISTS, id).set(element!.toJson());
  await CloudManager.getCollection(CloudManager.USER_LISTS).add(
    UserListsModel(userId: auth.currentUser?.uid ?? "", listId: id).toJson(),
  );

  model.list.removeWhere((element) => element.id == id);
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));

  c.theList.value.inCloud = true;
  c.list.firstWhereOrNull((element) => element.id == id)?.inCloud = true;
  c.list.refresh();
  c.theList.refresh();
  todoController.setLoading;
}

void switchNotification() {
  ListsController c = Get.put(ListsController());
  var notifications = StorageManager.instance.getList(SKey.NOTIFICATIONS);
  TodoListSettingsViewController todoController = Get.put(TodoListSettingsViewController());
  if (todoController.notification.value) {
    todoController.notification.value = false;
    notifications.add(c.theList.value.id);
    StorageManager.instance.setList(SKey.NOTIFICATIONS, notifications);
  } else {
    todoController.notification.value = true;
    notifications.removeWhere((id) => id == c.theList.value.id);
    StorageManager.instance.setList(SKey.NOTIFICATIONS, notifications);
  }
  todoController.notification.refresh();
}

void getNotification() {
  ListsController c = Get.put(ListsController());
  var notifications = StorageManager.instance.getList(SKey.NOTIFICATIONS);
  TodoListSettingsViewController todoController = Get.put(TodoListSettingsViewController());

  todoController.notification.value = !notifications.contains(c.theList.value.id);
}
