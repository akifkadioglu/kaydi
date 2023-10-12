import 'dart:convert';

import 'package:get/get.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:uuid/uuid.dart';

void createTask(String task, String list_id) {
  ListsController c = Get.put(ListsController());

  var uuid = Uuid();

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);

  var newTask = Task(id: uuid.v1(), task: task, isChecked: false);
  model.list.firstWhere((element) => element.id == list_id).task.add(newTask);

  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  
  c.task.add(newTask);
}
