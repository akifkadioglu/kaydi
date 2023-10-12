import 'dart:convert';

import 'package:get/get.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';

void leaveFromList(String id) {
  ListsController c = Get.put(ListsController());

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  model.list.removeWhere((element) => element.id == id);
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  c.list.removeWhere((element) => element.id == id);
}
