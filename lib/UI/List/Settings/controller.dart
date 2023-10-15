import 'dart:convert';

import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/List/Settings/view_controller.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';

void checkCloud(String id) {
  TodoListSettingsViewController c = Get.put(TodoListSettingsViewController());
  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  c.inCloud.value = model.list.firstWhereOrNull((element) => element.id == id)?.inCloud ?? false;
}

void leaveFromList(String id) {
  ListsController c = Get.put(ListsController());

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  model.list.removeWhere((element) => element.id == id);
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  c.list.removeWhere((element) => element.id == id);
  c.list.refresh();
}

void moveToCloud(String id) {
  ListsController c = Get.put(ListsController());
  TodoListSettingsViewController todoController = Get.put(TodoListSettingsViewController());

  todoController.setLoading;

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  model.list.firstWhereOrNull((element) => element.id == id)?.inCloud = true;
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  c.list.firstWhereOrNull((element) => element.id == id)?.inCloud = true;
  todoController.inCloud.value = true;
  c.list.refresh();

  todoController.setLoading;
}
